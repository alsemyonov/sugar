# Generated by jeweler
# DO NOT EDIT THIS FILE
# Instead, edit Jeweler::Tasks in Rakefile, and run `rake gemspec`
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sugar}
  s.version = "0.0.34"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Alexander Semyonov"]
  s.date = %q{2009-10-14}
  s.email = %q{rotuka@tokak.ru}
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
     "lib/sugar/actioncontroller.rb",
     "lib/sugar/actionview.rb",
     "lib/sugar/actionview/forms.rb",
     "lib/sugar/actionview/structure.rb",
     "lib/sugar/activerecord.rb",
     "lib/sugar/locales/de.yml",
     "lib/sugar/locales/en.yml",
     "lib/sugar/locales/ru.yml",
     "sugar.gemspec",
     "test/sugar_test.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/krasivotokak/sugar}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
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
