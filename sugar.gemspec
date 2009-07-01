# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sugar}
  s.version = "0.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Alexander Semyonov"]
  s.date = %q{2009-07-01}
  s.email = %q{rotuka@rotuka.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "init.rb",
     "lib/sugar.rb",
     "lib/sugar/actionpack.rb",
     "lib/sugar/activerecord.rb",
     "sugar.gemspec",
     "test/sugar_test.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/rotuka/sugar}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{Some sugar for rails apps}
  s.test_files = [
    "test/sugar_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
