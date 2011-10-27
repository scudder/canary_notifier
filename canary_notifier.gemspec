Gem::Specification.new do |s|
  s.name = 'canary_notifier'
  s.version = '0.0.8'
  s.authors = ["Henry Scudder"]
  s.date = %q{2011-10-27}
  s.summary = "Exception notification to Canary for Rails apps"
  s.email = "support@canaryhq.com"

  s.files = `git ls-files`.split("\n")
  s.require_path = 'lib'

  s.add_dependency("rest-client")
end
