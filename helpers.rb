require "rspec"

shared_examples_for "inner" do
  before(:each) do
    puts "inner before each"
  end
end

shared_examples_for "outer" do
  before(:each) do
    puts "outer before each"
  end
end

describe "Test" do
  it_behaves_like "outer" do
    describe "inner test" do
      it_behaves_like "inner" do
        it "should not pass" do
          puts "not pass =("
        end
        it "should pass" do
          puts "pass =)"
        end
      end
    end
    it "third pass" do
      puts "pass =)"
    end
  end
  it "third pass" do
    puts "pass =)"
  end
end

# ****************** code for rspec running **************
RSpec::Core::Runner.instance_variable_set '@autorun_disabled', true
config_options = RSpec::Core::ConfigurationOptions.new [
                                                           '--format', 'j', '--out', 'rspec_result.json',
                                                           '--format', 'h', '--out', 'rspec_result.html',
                                                           '--format', 'progress'
                                                       ]
config_options.parse_options
RSpec::Core::CommandLine.new(config_options, RSpec.configuration, RSpec.world).run(STDERR, STDOUT)
# ***********************************************************