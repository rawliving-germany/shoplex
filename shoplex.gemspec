# frozen_string_literal: true

require_relative "lib/shoplex/version"

Gem::Specification.new do |spec|
  spec.name = "shoplex"
  spec.version = Shoplex::VERSION
  spec.authors = ["Felix Wolfsteller"]
  spec.email = ["felix.wolfsteller@gmail.com"]

  spec.summary = "shopware csv invoice export to lexware csv import"
  spec.description = "Converts a file exported from shopware 5 invoice data into booking lines for lexware accounting software"
  spec.homepage = "https://github.com/rawliving-germany/shoplex"
  spec.required_ruby_version = ">= 3.2.0"

  #spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  #spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
