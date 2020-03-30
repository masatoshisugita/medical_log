# -*- encoding: utf-8 -*-
# stub: actionmailer 6.0.2.2 ruby lib

Gem::Specification.new do |s|
  s.name = "actionmailer".freeze
  s.version = "6.0.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/rails/rails/issues", "changelog_uri" => "https://github.com/rails/rails/blob/v6.0.2.2/actionmailer/CHANGELOG.md", "documentation_uri" => "https://api.rubyonrails.org/v6.0.2.2/", "mailing_list_uri" => "https://groups.google.com/forum/#!forum/rubyonrails-talk", "source_code_uri" => "https://github.com/rails/rails/tree/v6.0.2.2/actionmailer" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["David Heinemeier Hansson".freeze]
  s.date = "2020-03-19"
  s.description = "Email on Rails. Compose, deliver, and test emails using the familiar controller/view pattern. First-class support for multipart email and attachments.".freeze
  s.email = "david@loudthinking.com".freeze
  s.homepage = "https://rubyonrails.org".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.5.0".freeze)
  s.requirements = ["none".freeze]
  s.rubygems_version = "2.6.11".freeze
  s.summary = "Email composition and delivery framework (part of Rails).".freeze

  s.installed_by_version = "2.6.11" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<actionpack>.freeze, ["= 6.0.2.2"])
      s.add_runtime_dependency(%q<actionview>.freeze, ["= 6.0.2.2"])
      s.add_runtime_dependency(%q<activejob>.freeze, ["= 6.0.2.2"])
      s.add_runtime_dependency(%q<mail>.freeze, [">= 2.5.4", "~> 2.5"])
      s.add_runtime_dependency(%q<rails-dom-testing>.freeze, ["~> 2.0"])
    else
      s.add_dependency(%q<actionpack>.freeze, ["= 6.0.2.2"])
      s.add_dependency(%q<actionview>.freeze, ["= 6.0.2.2"])
      s.add_dependency(%q<activejob>.freeze, ["= 6.0.2.2"])
      s.add_dependency(%q<mail>.freeze, [">= 2.5.4", "~> 2.5"])
      s.add_dependency(%q<rails-dom-testing>.freeze, ["~> 2.0"])
    end
  else
    s.add_dependency(%q<actionpack>.freeze, ["= 6.0.2.2"])
    s.add_dependency(%q<actionview>.freeze, ["= 6.0.2.2"])
    s.add_dependency(%q<activejob>.freeze, ["= 6.0.2.2"])
    s.add_dependency(%q<mail>.freeze, [">= 2.5.4", "~> 2.5"])
    s.add_dependency(%q<rails-dom-testing>.freeze, ["~> 2.0"])
  end
end
