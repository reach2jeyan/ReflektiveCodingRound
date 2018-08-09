require 'parallel'
require 'cucumber'
require 'cucumber/rake/task'
require 'rake'

#DO NOT include rspec as it is not supported by cucumber, both need to run induvidually.


def run_cucumber(cucumber_opts) #Configure cucumber to run rake tasks through profiles.
  Cucumber::Rake::Task.new do |t|
    t.cucumber_opts = cucumber_opts
  end
  Rake::MultiTask[:cucumber].invoke
end

task :Chrome do
  run_cucumber('BROWSER=chrome --format json --out chrome.json --format pretty  -f rerun --out rerun.txt || cucumber @rerun.txt')
end

task :FireFox do
  run_cucumber('BROWSER=firefox --format json --out firefox.json --format pretty  -f rerun --out rerun.txt || cucumber @rerun.txt')
end

task :rerun do
  if File.size("cucumber_failures.log") == 0
    puts "==== No failures. Everything Passed ========="
  else
    puts " =========Re-running Failed Scenarios============="
    system "cucumber @cucumber_failures.log -f pretty"
  end
end


def run_parallel
  Parallel.each([:FireFox, :Chrome]) {|task| Rake::Task[task].invoke }
end

task :all do
  run_parallel
end
