$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "mongoid-counter_cache"
  s.version     = "0.0.1"
  s.authors     = ["Mikael Andersson"]
  s.email       = ["mikael@invoke.se"]
  s.homepage    = ""
  s.summary     = "Counter cache module for Mongoid with Resque integration"
  s.description = "Counter cache module for Mongoid with Resque integration"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 3.2.0"
  s.add_dependency "mongoid", "~> 2.4.0"
  s.add_dependency "bson_ext", "~> 1.5"
  s.add_dependency "resque", ">= 1.20.0"

  s.add_development_dependency "turn", ">= 0.9"
  s.add_development_dependency "debugger", ">= 1.1"
end
