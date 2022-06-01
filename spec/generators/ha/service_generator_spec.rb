require "spec_helper"
require_relative "../../../lib/generators/ha/service/service_generator"

RSpec.describe Ha::Generators::ServiceGenerator, type: :generator do
  let(:file) { "./tmp/app/services/foo/bar/baz.rb" }
  let(:spec_file) { "./tmp/spec/services/foo/bar/baz_spec.rb" }

  around(:each) do |example|
    cleanup

    example.run

    cleanup
  end

  context "service" do
    it "creates correct service file" do
      # rails g ha:service Foo::Bar::Baz
      # used destination_root here to avoid deleting real files
      described_class.new(["Foo::Bar::Baz"], [], destination_root: "./tmp").invoke_all

      expect(File.exist?(file)).to be_truthy
      expect(File.binread(file)).to eq expected_file_content
    end
  end

  context "service spec" do
    it "creates correct service spec file" do
      # rails g ha:service Foo::Bar::Baz
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

      class Foo::Bar::Baz < ApplicationService
        def initialize
        end

        def call
          true
        end
      end
    FILE
  end

  def expected_spec_content
    <<~FILE
      # frozen_string_literal: true

      require "rails_helper"

      RSpec.describe Foo::Bar::Baz, type: :service do
        describe ".call" do
          it "returns true" do
            result = described_class.call

            expect(result).to eq true
          end
        end
      end
    FILE
  end
end
