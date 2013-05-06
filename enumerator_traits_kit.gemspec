# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'enumerator_traits_kit/version'

Gem::Specification.new do |gem|
  gem.name          = "enumerator-traits-kit"
  gem.version       = EnumeratorTraitsKit::VERSION
  gem.authors       = ["Bill"]
  gem.email         = ["bill.burcham@gmail.com"]
  gem.description   = %q{a collection of useful Ruby sequence traits and operations}
  gem.summary       = %q{Leverages a family of monotonic traits to build an intersection operator (&) on sequences}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'enumerator-traits'
end
