require 'spec/runner/option_parser'

module Spec
  module Runner
    # Facade to run specs without having to fork a new ruby process (using `spec ...`)
    class CommandLine
      class << self
        # Runs examples.
        def run(instance_rspec_options=Spec::Runner.options)
          # NOTE - this call to Spec::Runner.init_options is not spec'd, but
          # neither is any of this swapping of $rspec_options. That is all
          # here to enable rspec to run against itself and maintain coverage
          # in a single process. Therefore, DO NOT mess with this stuff unless
          # you know what you are doing!
          orig_rspec_options = Spec::Runner.options
          Spec::Runner.init_options(instance_rspec_options)
          begin
            return instance_rspec_options.run_examples
          ensure
            Spec::Runner.init_options(orig_rspec_options)
          end
        end
      end
    end
  end
end
