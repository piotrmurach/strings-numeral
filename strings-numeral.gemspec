lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "strings/numeral/version"

Gem::Specification.new do |spec|
  spec.name          = "strings-numeral"
  spec.version       = Strings::Numeral::VERSION
  spec.authors       = ["Piotr Murach"]
  spec.email         = ["me@piotrmurach.com"]
  spec.summary       = %q{Express numbers as word numerals}
  spec.description   = %q{Express numbers as word numerals like cardinal, ordinal, roman and monetary}
  spec.homepage      = "https://github.com/piotrmurach/strings-numeral"
  spec.license       = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
    spec.metadata["changelog_uri"] = "https://github.com/piotrmurach/strings-numeral/blob/master/CHANGELOG.md"
    spec.metadata["documentation_uri"] = "https://www.rubydoc.info/gems/strings-numeral"
    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/piotrmurach/strings-numeral"
  end

  spec.files         = Dir["lib/**/*"]
  spec.extra_rdoc_files = ["README.md", "CHANGELOG.md", "LICENSE.txt"]
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.0.0"

  spec.add_development_dependency "bundler", ">= 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"
end
