require 'rake/testtask'
require 'bundler'

desc "Run tests"
task :default => [:test]

Rake::TestTask.new { |t|
  t.verbose = true
  t.warning = true
}

Bundler::GemHelper.install_tasks
