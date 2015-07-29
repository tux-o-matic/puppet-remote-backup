source 'https://rubygems.org'
puppetversion = ENV.key?('PUPPET_VERSION') ? "= #{ENV['PUPPET_VERSION']}" : ['>= 3.6.0']

group :test do
  gem 'rake'
  gem 'puppet-lint'
  gem "puppet", ENV['PUPPET_VERSION']
  gem "puppet-syntax"
  gem "puppetlabs_spec_helper"
  gem "metadata-json-lint"
end