# danger-rails_best_practices

[![Build Status](https://badgen.net/travis/blooper05/danger-rails_best_practices?icon=travis)](https://travis-ci.com/blooper05/danger-rails_best_practices)
[![Dependency Status](https://api.dependabot.com/badges/status?host=github&repo=blooper05/danger-rails_best_practices)](https://dependabot.com)
[![Maintainability](https://badgen.net/codeclimate/maintainability/blooper05/danger-rails_best_practices?icon=codeclimate)](https://codeclimate.com/github/blooper05/danger-rails_best_practices)
[![Coverage](https://badgen.net/codeclimate/coverage/blooper05/danger-rails_best_practices?icon=codeclimate)](https://codeclimate.com/github/blooper05/danger-rails_best_practices)
[![Version](https://badgen.net/rubygems/v/danger-rails_best_practices?icon=ruby)](https://rubygems.org/gems/danger-rails_best_practices)
[![License](https://badgen.net/github/license/blooper05/danger-rails_best_practices?icon=github)](https://github.com/blooper05/danger-rails_best_practices/blob/master/LICENSE)

A [Danger](https://rubygems.org/gems/danger) plugin for [rails_best_practices](https://rubygems.org/gems/rails_best_practices).

## Installation

    $ gem install danger-rails_best_practices

## Usage

### rails_best_practices

Lints Ruby files via [rails_best_practices](https://rubygems.org/gems/rails_best_practices).
Results are sent as inline comments.

<blockquote>Running rails_best_practices
  <pre>
# Runs rails_best_practices on modified and added files in the PR
rails_best_practices.lint</pre>
</blockquote>

#### Methods

`lint` - Runs Ruby files through rails_best_practices.

## Development

1. Clone this repo
2. Run `bundle install` to setup dependencies.
3. Run `bundle exec rake spec` to run the tests.
4. Use `bundle exec guard` to automatically have tests run as you make changes.
5. Make your changes.
