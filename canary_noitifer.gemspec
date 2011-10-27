Gem::Specification.new do |s|
  s.name = 'canary_noitifer'
  s.version = '0.0.1'
  s.authors = ["Henry Scudder"]
  s.date = %q{2011-10-27}
  s.summary = "Exception notification to Canary for Rails apps"
  s.email = "support@canaryhq.com"

  s.files = `git ls-files`.split("\n")
  s.require_path = 'lib'

  #s.add_dependency("actionmailer", ">= 3.0.4")
  #s.add_development_dependency "rails", ">= 3.0.4"
  #s.add_development_dependency "sqlite3", ">= 1.3.4"
end
