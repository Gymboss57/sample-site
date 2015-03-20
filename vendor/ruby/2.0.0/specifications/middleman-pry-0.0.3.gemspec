# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "middleman-pry"
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Andrew Kvalheim"]
  s.date = "2014-02-02"
  s.email = ["Andrew@Kvalhe.im"]
  s.homepage = "https://github.com/AndrewKvalheim/middleman-pry"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.14"
  s.summary = "Use Pry as the Middleman console."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<middleman-core>, [">= 3.2.2"])
      s.add_runtime_dependency(%q<pry>, [">= 0.9.12"])
    else
      s.add_dependency(%q<middleman-core>, [">= 3.2.2"])
      s.add_dependency(%q<pry>, [">= 0.9.12"])
    end
  else
    s.add_dependency(%q<middleman-core>, [">= 3.2.2"])
    s.add_dependency(%q<pry>, [">= 0.9.12"])
  end
end
