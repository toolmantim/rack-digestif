Gem::Specification.new do |s|
  s.name = 'rack-digestif'
  s.version = '0.1'

  s.summary = "A rack middleware to remove the digest from Sprockets asset requests, preventing the chance of a 404 when the asset's digest changes"
  s.description = s.summary

  s.author = 'Tim Lucas'
  s.email = 't@toolmantim.com'
  s.homepage = 'http://github.com/toolmantim/rack-digestif'

  s.files        = Dir['Readme.md', 'MIT-LICENSE', 'Rakefile', 'rack-digestif.gemspec', 'lib/**/*']
  s.test_files   = Dir['test/*']
  s.require_path = 'lib'
  s.requirements << 'none'
end
