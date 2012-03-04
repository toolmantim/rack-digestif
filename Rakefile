require 'rake/testtask'
require 'bundler'

desc "Run tests"
task :default => [:test]

Rake::TestTask.new do |t|
  t.warning = true
  t.verbose = true
  t.test_files = FileList['spec/*_spec.rb']
end

Bundler::GemHelper.install_tasks
