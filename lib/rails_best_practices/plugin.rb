require 'rails_best_practices'

module Danger
  # Lints Ruby files via [rails_best_practices](https://rubygems.org/gems/rails_best_practices).
  # Results are sent as inline comments.
  #
  # @example Running rails_best_practices
  #
  #          # Runs rails_best_practices on modified and added files in the PR
  #          rails_best_practices.lint
  #
  # @see  blooper05/danger-rails_best_practices
  # @tags ruby, rails, rails_best_practices, lint
  class DangerRailsBestPractices < Plugin
    # Runs Ruby files through rails_best_practices.
    # @return [Array<RailsBestPractices::Core::Error, nil>]
    def lint
      files_to_lint = fetch_files_to_lint
      lint_errors   = run_linter(files_to_lint)
      warn_each_line(lint_errors)
    end

    private

    def run_linter(files_to_lint)
      analyzer = ::RailsBestPractices::Analyzer.new(
        '.', 'silent' => true, 'only' => files_to_lint
      )
      analyzer.analyze
      analyzer.errors
    end

    def fetch_files_to_lint
      files = git.modified_files + git.added_files
      files.map { |file| Regexp.compile(Regexp.escape(file)) }.to_a
    end

    def warn_each_line(lint_errors)
      current_dir = "#{Dir.pwd}/"
      lint_errors.each do |error|
        message = error.message.capitalize
        file    = error.filename.sub(current_dir, '')
        line    = error.line_number.to_i
        warn(message, file: file, line: line)
      end
    end
  end
end
