require "rails/generators"

module HaGenerators
  module Generators
    class AbstractGenerator < Rails::Generators::NamedBase
      def generate_file
        filepath = build_filepath("app/#{@type_name}s", class_name, @suffix)
        dir = File.dirname(filepath)
        FileUtils.mkdir_p(dir) unless File.exist?(dir)

        template "#{@type_name}.erb", filepath
      end

      def generate_spec_file
        filepath = build_filepath("spec/#{@type_name}s", class_name, @spec_suffix)
        dir = File.dirname(filepath)
        FileUtils.mkdir_p(dir) unless File.exist?(dir)

        template "#{@type_name}_spec.erb", filepath
      end

      private

      def build_filepath(folder_name, class_name, suffix)
        "#{folder_name}/#{class_name.underscore}#{suffix}"
      end
    end
  end
end
