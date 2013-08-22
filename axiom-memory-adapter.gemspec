# encoding: utf-8

require File.expand_path('../lib/axiom/adapter/memory/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = 'axiom-memory-adapter'
  gem.version     = Axiom::Adapter::Memory::VERSION.dup
  gem.authors     = ['Dan Kubb']
  gem.email       = 'dan.kubb@gmail.com'
  gem.description = 'Use Axiom relations with an in-memory datastore'
  gem.summary     = 'Axiom Memory adapter'
  gem.homepage    = 'https://github.com/dkubb/axiom-memory-adapter'
  gem.licenses    = %w[MIT]

  gem.require_paths    = %w[lib]
  gem.files            = `git ls-files`.split($/)
  gem.test_files       = `git ls-files -- spec/{unit,integration}`.split($/)
  gem.extra_rdoc_files = %w[LICENSE README.md CONTRIBUTING.md TODO]

  gem.add_runtime_dependency('axiom',       '~> 0.1.1')
  gem.add_runtime_dependency('thread_safe', '~> 0.1.0')

  gem.add_development_dependency('bundler', '~> 1.3', '>= 1.3.5')
end
