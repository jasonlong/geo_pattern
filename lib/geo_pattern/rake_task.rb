require 'rake'
require 'rake/tasklib'
require 'logger'

module GeoPattern
  # Rake Task
  #
  # This task can be used to generate pattern files
  class RakeTask < ::Rake::TaskLib
    include ::Rake::DSL if defined?(::Rake::DSL)

    # @!attribute [r] name
    #   Name of task.
    attr_reader :name

    # @!attribute [r] description
    #   A description for the task
    attr_reader :description

    # @!attribute [r] verbose (true)
    #   Use verbose output. If this is set to true, the task will print the
    #   executed spec command to stdout.
    attr_reader :verbose

    private

    attr_reader :task_arguments, :task_block, :logger, :working_directory

    # Create task instance
    #
    # @param [String] description
    #   A description for the task
    #
    # @param [String] name
    #   The name for the task (including namespace), e.g. namespace1:task1
    #
    # @param [Array] arguments
    #   Arguments for the task. Look
    #   [here](http://viget.com/extend/protip-passing-parameters-to-your-rake-tasks)
    #   for a better description on how to use arguments in rake tasks
    #
    # @yield
    #   A block which is called before the "run_task"-method is called. The
    #   parameters it taskes depends on the number of parameters the block
    #   can take. If the block is defined which two parameters, it takes two
    #   parameters from the paramter 'arguments'.
    def initialize(opts = {}, &task_block)
      @options = {
        description: nil,
        name: GeoPattern::Helpers.underscore(self.class.to_s.split(/::/).slice(-2..-1).join(':').gsub(/Task$/, '')),
        arguments: [],
        logger: ::Logger.new($stderr),
        working_directory: Dir.getwd
      }.merge opts

      before_initialize

      raise ArgumentError, :description if @options[:description].nil?

      @description       = @options[:description]
      @task_arguments    = Array(@options[:arguments])
      @task_block        = task_block
      @logger            = @options[:logger]
      @working_directory = @options[:working_directory]
      @name              = @options[:name]

      after_initialize

      define_task
    end

    # Run code after initialize
    def after_initialize; end

    # Run code before initialize
    def before_initialize; end

    # Define task
    def define_task
      desc description unless ::Rake.application.last_comment

      task name, *task_arguments do |_, task_args|
        RakeFileUtils.__send__(:verbose, verbose) do
          instance_exec(*[self, task_args].slice(0, task_block.arity), &task_block) if task_block.respond_to? :call
          run_task verbose
        end
      end
    end

    # Run code if task is executed
    def run_task(_verbose); end

    public

    # Binding to instance
    def instance_binding
      binding
    end

    # Include module in instance
    def include(modules)
      modules = Array(modules)

      modules.each { |m| self.class.include m }
    end
  end
end
