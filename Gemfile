source :rubygems

using_edge_mail_gem = ENV['USING_EDGE_MAIL_GEM']

if using_edge_mail_gem == "true"
  gem "mail", ">= 2.4.1"
else
  gem "mail", ">= 2.2.5"
end

rails_version = ENV['MAIL_ISO_2022_JP_RAILS_VERSION']

group :development, :test do
  gem "rake"
  gem "bundler"
  if using_edge_mail_gem == "true"
    gem "activesupport"
  elsif rails_version == "edge"
    gem "actionmailer", :git => "git://github.com/rails/rails.git"
  elsif rails_version && rails_version.strip != ""
    gem "actionmailer", rails_version
  else
    gem "actionmailer", ">= 3.0.0"
  end
  gem "rdoc", ">= 3.12"
end