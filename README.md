# guard-unicorn

Makes sure Unicorn web server is running.

This is a WIP. Not recommended for use, 'cause, you know, it won't work.

## Install

Please be sure to have [Guard](http://github.com/guard/guard) installed before continuing.

Install the gem:

    gem install guard-unicorn

or add it to your Gemfile (inside your development and/or test group):

    gem 'guard-unicorn'

Add guard definition to your Guardfile by running this command:

    guard init unicorn

## Usage

Please read [Guard usage doc](http://github.com/guard/guard#readme).

## Configuration

You can get by with just this:

    guard 'unicorn'

Slightly more detailed:

    guard 'unicorn', :environment => 'development' do
      watch(%r{^lib/(.+)\.rb})
    end

Default options are:

        :host         => '0.0.0.0',
        :port         => 8080,
        :environment  => nil,
        :config_file  => nil


## Building and deploying gem

 * Update the version number in `lib/guard/unicorn/version.rb`
 * Update `CHANGELOG.md`
 * Build the gem:
 
    gem build guard-unicorn.gemspec

 * Push to rubygems.org:
 
    gem push guard-unicorn-0.0.2.gem

## Testing the gem locally

    gem install guard-unicorn-0.0.2.gem

## Notes

Heavily inspired by [guard-webrick](https://github.com/guard/guard-webrick) and [guard-process](https://github.com/guard/guard-process).
