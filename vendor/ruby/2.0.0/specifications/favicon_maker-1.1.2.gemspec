# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "favicon_maker"
  s.version = "1.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Andreas Follmann"]
  s.date = "2014-02-28"
  s.description = "Create favicon files in various sizes from one or multiple base images"
  s.homepage = "https://github.com/follmann/favicon_maker"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.14"
  s.summary = "Create favicon files in various sizes from one or multiple base images"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mini_magick>, ["~> 3.7"])
      s.add_runtime_dependency(%q<docile>, ["~> 1.1.3"])
      s.add_development_dependency(%q<rspec>, [">= 2.14.1", "~> 2.14"])
      s.add_development_dependency(%q<guard-rspec>, ["~> 1.2"])
    else
      s.add_dependency(%q<mini_magick>, ["~> 3.7"])
      s.add_dependency(%q<docile>, ["~> 1.1.3"])
      s.add_dependency(%q<rspec>, [">= 2.14.1", "~> 2.14"])
      s.add_dependency(%q<guard-rspec>, ["~> 1.2"])
    end
  else
    s.add_dependency(%q<mini_magick>, ["~> 3.7"])
    s.add_dependency(%q<docile>, ["~> 1.1.3"])
    s.add_dependency(%q<rspec>, [">= 2.14.1", "~> 2.14"])
    s.add_dependency(%q<guard-rspec>, ["~> 1.2"])
  end
end
