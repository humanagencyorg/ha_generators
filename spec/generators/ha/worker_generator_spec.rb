require "spec_helper"
require_relative "../../../lib/generators/ha/worker/worker_generator"

RSpec.describe Ha::Generators::WorkerGenerator, type: :generator do
  let(:file) { "./tmp/app/workers/foo/bar/baz_worker.rb" }
  let(:spec_file) { "./tmp/spec/workers/foo/bar/baz_worker_spec.rb" }

  around(:each) do |example|
    cleanup

    example.run

    cleanup
  end

  context "worker" do
    it "creates correct worker file" do
      # rails g ha:worker Foo::Bar::Baz
      # used destination_root here to avoid deleting real files
      described_class.new(["Foo::Bar::Baz"], [], destination_root: "./tmp").invoke_all

      expect(File.exist?(file)).to be_truthy
      expect(File.binread(file)).to eq expected_file_content
    end
  end

  context "worker spec" do
    it "creates correct worker spec file" do
      # rails g ha:worker Foo::Bar::Baz
      # used destination_root here to avoid deleting real files
      described_class.new(["Foo::Bar::Baz"], [], destination_root: "./tmp").invoke_all

      expect(File.exist?(spec_file)).to be_truthy
      expect(File.binread(spec_file)).to eq expected_spec_content
    end
  end

  def cleanup
    File.delete(file) if File.exist?(file)
    File.delete(spec_file) if File.exist?(spec_file)
    expect(File.exist?(file)).to be_falsy
    expect(File.exist?(spec_file)).to be_falsy
  end

  def expected_file_content
    <<~FILE
      # frozen_string_literal: true

      class Foo::Bar::Baz
        include Sidekiq::Worker

        def perform
          true
        end
      end
    FILE
  end

  def expected_spec_content
    <<~FILE
      # frozen_string_literal: true

      require "rails_helper"

      RSpec.describe Foo::Bar::Baz do
        describe "#perform" do
          it "returns true" do
            result = described_class.new.perform

            expect(result).to eq true
          end
        end
      end
    FILE
  end
end
