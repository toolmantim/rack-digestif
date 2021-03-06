Gem::Specification.new do |s|
  s.name = 'rack-digestif'
  s.version = '0.1'

  s.summary = "A rack middleware that ensures Sprockets assets are served regardless of whether the asset digest matches"
  s.description = s.summary

  s.author = 'Tim Lucas'
  s.email = 't@toolmantim.com'
  s.homepage = 'http://github.com/toolmantim/rack-digestif'

  s.files        = Dir['Readme.md', 'MIT-LICENSE', 'Rakefile', 'rack-digestif.gemspec', 'lib/**/*']
  s.test_files   = Dir['spec/*']
  s.require_path = 'lib'
  s.requirements << 'none'
  
  s.add_dependency 'rack'
  
  s.add_development_dependency "minitest"
  s.add_development_dependency "bundler"
  s.add_development_dependency "rake"
end
