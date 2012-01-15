version = File.read(File.expand_path("../VERSION",__FILE__)).strip

Gem::Specification.new do |s|
  s.name        = "mail-iso-2022-jp"
  s.version     = version
  s.authors     = ["Kohei MATSUSHITA", "Tsutomu KURODA"]
  s.email       = "hermes@oiax.jp"
  s.homepage    = "https://github.com/kuroda/mail-iso-2022-jp"
  s.description = "A patch that provides 'mail' gem with iso-2022-jp conversion capability."
  s.summary     = "A patch that provides 'mail' gem with iso-2022-jp conversion capability."

  s.platform = Gem::Platform::RUBY

  s.add_dependency "mail", ">= 2.2.5"
  s.add_development_dependency "actionmailer", ">= 3.0.0"
  s.add_development_dependency "rdoc", ">= 3.12"

  s.require_path = "lib"
  s.files = %w(README.md Gemfile Rakefile) + Dir.glob("lib/**/*")
end