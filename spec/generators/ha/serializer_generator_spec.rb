require "spec_helper"
require_relative "../../../lib/generators/ha/serializer/serializer_generator"

RSpec.describe Ha::Generators::SerializerGenerator, type: :generator do
  let(:file) { "./tmp/app/serializers/foo/bar/baz_serializer.rb" }
  let(:spec_file) { "./tmp/spec/serializers/foo/bar/baz_serializer_spec.rb" }

  around(:each) do |example|
    cleanup

    example.run

    cleanup
  end

  context "serializer" do
    it "creates correct serializer file" do
      # rails g ha:serializer Foo::Bar::Baz attr1 attr2
      # used destination_root here to avoid deleting real files
      described_class.new(["Foo::Bar::Baz", "attr1", "attr2"], [], destination_root: "./tmp").invoke_all

      expect(File.exist?(file)).to be_truthy
      expect(File.binread(file)).to eq expected_file_content
    end
  end

  context "serializer spec" do
    it "creates correct serializer spec file" do
      # rails g ha:serializer Foo::Bar::Baz attr1 attr2
      # used destination_root here to avoid deleting real files
      described_class.new(["Foo::Bar::Baz", "attr1", "attr2"], [], destination_root: "./tmp").invoke_all

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

      class Foo::Bar::BazSerializer
        include JSONAPI::Serializer

        set_key_transform :camel_lower

        attributes :attr1, :attr2
      end
    FILE
  end

  def expected_spec_content
    <<~FILE
      # frozen_string_literal: true

      require "rails_helper"

      RSpec.describe Foo::Bar::BazSerializer do
        describe "attributes" do
          it "returns attributes by baz" do
            baz = create(:baz)

            attributes = described_class.new(baz).serializable_hash[:data][:attributes]

            expect(attributes[:attr1]).to eq(baz.attr1)
            expect(attributes[:attr2]).to eq(baz.attr2)
          end
        end
      end
    FILE
  end
end
