require 'rubygems'
require 'bundler/setup'

Bundler.require

require 'cucumber/rake/task'


task :non_deterministic do
    system("rm failures.txt")
    run_successfull = run_rake_task("bose")

    if !run_successfull
      allNDFailures = []
      failedTags = []
      File.open('failures.txt') do |file|
        file.each_line do |line|
          failedTags << line
        end
      end
      p failedTags
      failedTags.each do |tagsPerScenario|
        allNDFailures << tagsPerScenario.include?("non_deterministic")
      end
      p allNDFailures
      if(allNDFailures.include?(false))
        exec('exit 1')
      else
        exec('exit 10')
      end
    end
end

def run_rake_task(name)
  begin
    Rake::Task[name].invoke
  rescue Exception => e
    return false
  end
  true
end


Cucumber::Rake::Task.new(:bose) do |t|
  t.cucumber_opts = "--tags @x --format pretty --format html -o output/report.html"
end