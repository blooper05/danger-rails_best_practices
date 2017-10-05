require 'rails_best_practices'

module Danger
  # This is your plugin class. Any attributes or methods you expose here will
  # be available from within your Dangerfile.
  #
  # To be published on the Danger plugins site, you will need to have
  # the public interface documented. Danger uses [YARD](http://yardoc.org/)
  # for generating documentation from your plugin source, and you can verify
  # by running `danger plugins lint` or `bundle exec rake spec`.
  #
  # You should replace these comments with a public description of your library.
  #
  # @example Ensure people are well warned about merging on Mondays
  #
  #          my_plugin.warn_on_mondays
  #
  # @see  blooper05/danger-rails_best_practices
  # @tags monday, weekends, time, rattata
  #
  class DangerRailsBestPractices < Plugin
    # A method that you can call from your Dangerfile
    # @return   [Array<String>]
    #
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
      Array(files.map { |file| /#{file}/ })
    end

    def warn_each_line(lint_errors)
      current_dir = "#{Dir.pwd}/"
      lint_errors.map do |error|
        file = error.filename.sub(current_dir, '')
        line = error.line_number.to_i
        warn(error.message, file: file, line: line)
      end
    end
  end
end
