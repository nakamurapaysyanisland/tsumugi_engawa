# -*- encoding: utf-8 -*-
# stub: gretel 5.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "gretel".freeze
  s.version = "5.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "changelog_uri" => "https://github.com/kzkn/gretel/blob/main/CHANGELOG.md" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Lasse Bunk".freeze, "Kazuki Nishikawa".freeze]
  s.date = "2025-12-09"
  s.description = "Gretel is a Ruby on Rails plugin that makes it easy yet flexible to create breadcrumbs.".freeze
  s.email = ["kzkn@users.noreply.github.com".freeze]
  s.homepage = "https://github.com/kzkn/gretel".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.3.7".freeze
  s.summary = "Flexible Ruby on Rails breadcrumbs plugin.".freeze

  s.installed_by_version = "3.3.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<railties>.freeze, [">= 6.1"])
    s.add_runtime_dependency(%q<actionview>.freeze, [">= 6.1"])
  else
    s.add_dependency(%q<railties>.freeze, [">= 6.1"])
    s.add_dependency(%q<actionview>.freeze, [">= 6.1"])
  end
end
