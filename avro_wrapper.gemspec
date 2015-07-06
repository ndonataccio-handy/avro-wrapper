Gem::Specification.new do |s|
  s.name        = 'avro-wrapper'
  s.version     = '0.0.2'
  s.date        = Time.now.strftime("%Y-%m-%d")
  s.summary     = "Wrapper for Avro"
  s.description = ""
  s.authors     = ["Razvan Popa"]
  s.email       = 'razvan@itnovate.ro'
  s.files       = ["lib/avro_wrapper.rb"]
  s.add_dependency 'avro', '~> 1.7'
  s.add_development_dependency 'rspec', '~> 3.2'
  s.homepage    = 'https://github.com/razvan-/avro-wrapper'
  s.license     = 'MIT'
end
