require 'rake/testtask'
require 'rake/packagetask'
require 'rubygems/package_task'

desc "Run tests"
task :default => [:test]

Rake::TestTask.new { |t|
  t.verbose = true
  t.warning = true
}

spec = eval(File.read('rack-digestif.gemspec'))
Gem::PackageTask.new(spec) do |p|
  p.gem_spec = spec
end

desc "Release to gemcutter"
task :release => :package do
  require 'rake/gemcutter'
  Rake::Gemcutter::Tasks.new(spec).define
  Rake::Task['gem:push'].invoke
end
