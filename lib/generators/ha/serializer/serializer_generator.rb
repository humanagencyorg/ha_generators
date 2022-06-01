require_relative "../abstract_generator"

module Ha
  module Generators
    class SerializerGenerator < AbstractGenerator
      source_root File.expand_path("templates", __dir__)
      argument :attributes, type: :array, default: [], banner: "attribute"

      def initialize(*args)
        @type_name = "serializer"
        @suffix = "_serializer.rb"
        @spec_suffix = "_serializer_spec.rb"
        super
      end
    end
  end
end
