# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'guard/unicorn/version'

Gem::Specification.new do |s|
  s.name        = 'guard-unicorn'
  s.version     = Guard::UnicornVersion::VERSION
  s.authors     = ['Michael Watts']
  s.email       = ['mikwat@github.com']
  s.homepage    = 'https://github.com/mikwat/guard-unicorn'
  s.summary     = %q{Guard 2.0 gem for unicorn}
  s.description = %q{Guard::Unicorn controls re/starting unicorn}

  s.required_rubygems_version = '>= 1.3.6'
  s.rubyforge_project = 'guard-unicorn'

  s.add_dependency 'guard', '~> 2.1'
  s.add_dependency 'guard-compat', '~> 1.1'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rspec',           '>= 2.6.0'
  s.add_development_dependency 'guard-rspec',     '>= 0.4.5'
  s.add_development_dependency 'guard-bundler',   '>= 0.1.3'
  s.add_development_dependency 'rake'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
end
