require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'



task :default => :cucumber

task :cucumber do
  Cucumber::Rake::Task.new(:features) do |t|
    t.cucumber_opts = "features --format pretty"
  end
end
