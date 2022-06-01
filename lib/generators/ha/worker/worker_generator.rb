require_relative "../abstract_generator"

module Ha
  module Generators
    class WorkerGenerator < AbstractGenerator
      source_root File.expand_path("templates", __dir__)

      def initialize(*args)
        @type_name = "worker"
        @suffix = "_worker.rb"
        @spec_suffix = "_worker_spec.rb"
        super
      end
    end
  end
end
