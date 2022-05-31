require_relative "../abstract_generator"

module HaGeneratorsSample
  module Generators
    class ServiceGenerator < AbstractGenerator
      source_root File.expand_path("templates", __dir__)

      def initialize(*args)
        @type_name = "service"
        @suffix = ".rb"
        @spec_suffix = "_spec.rb"
        super
      end
    end
  end
end
