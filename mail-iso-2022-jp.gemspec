Gem::Specification.new do |s|
  s.name        = "mail-iso-2022-jp"
  s.version     = "1.0.9"
  s.authors     = ["Kohei MATSUSHITA", "Tsutomu KURODA"]
  s.email       = "hermes@oiax.jp"
  s.homepage    = "http://github.com/kuroda/mail-iso-2022-jp"
  s.description = "A patch that provides 'mail' gem with iso-2022-jp conversion capability."
  s.summary     = "A patch that provides 'mail' gem with iso-2022-jp conversion capability."

  s.platform = Gem::Platform::RUBY

  s.add_dependency('mail', ">= 2.2.5")

  s.require_path = 'lib'
  s.files = %w(README.md Gemfile Rakefile) + Dir.glob("lib/**/*")
end