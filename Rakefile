require 'rubygems'
require 'bundler/setup'

Bundler.require

require 'cucumber/rake/task'
require 'rest-client'


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
      if(!allNDFailures.include?(false))
        set_non_deterministic_property_in_go(get_current_pipeline_counter)
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

def get_current_pipeline_counter
  jobs = JSON.parse(RestClient.get('http://localhost:8153/go/api/jobs/FunctionalTests/run/run/history'))
  return {stage_counter: jobs["jobs"][0]["stage_counter"], pipeline_counter: jobs["jobs"][0]["pipeline_counter"] }

end

def set_non_deterministic_property_in_go(counters)
  url = "http://localhost:8153/go/properties/FunctionalTests/%{pipeline_counter}/run/%{stage_counter}/run/NonDeterministic" % counters
  p RestClient.post(url, {:value =>true})
end


Cucumber::Rake::Task.new(:bose) do |t|
  t.cucumber_opts = "--tags @x --format pretty --format html -o output/report.html"
end