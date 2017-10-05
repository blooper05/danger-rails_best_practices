# danger-rails_best_practices

[![Build Status](https://img.shields.io/travis/blooper05/danger-rails_best_practices.svg)](https://travis-ci.org/blooper05/danger-rails_best_practices)
[![Code Climate](https://img.shields.io/codeclimate/github/blooper05/danger-rails_best_practices.svg)](https://codeclimate.com/github/blooper05/danger-rails_best_practices)
[![Coverage](https://img.shields.io/codeclimate/coverage/github/blooper05/danger-rails_best_practices.svg)](https://codeclimate.com/github/blooper05/danger-rails_best_practices)
[![Dependency Status](https://img.shields.io/gemnasium/blooper05/danger-rails_best_practices.svg)](https://gemnasium.com/blooper05/danger-rails_best_practices)
[![Gem Version](https://img.shields.io/gem/v/danger-rails_best_practices.svg)](https://rubygems.org/gems/danger-rails_best_practices)
[![License](https://img.shields.io/github/license/blooper05/danger-rails_best_practices.svg)](https://github.com/blooper05/danger-rails_best_practices/blob/master/LICENSE)

A [danger](https://rubygems.org/gems/danger) plugin for [rails_best_practices](https://rubygems.org/gems/rails_best_practices).

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
