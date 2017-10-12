require File.expand_path('../spec_helper', __FILE__)

module Danger
  describe Danger::DangerRailsBestPractices do
    it 'should be a plugin' do
      expect(Danger::DangerRailsBestPractices.new(nil)).to be_a Danger::Plugin
    end

    describe 'with Dangerfile' do
      let(:dangerfile)           { testing_dangerfile }
      let(:rails_best_practices) { dangerfile.rails_best_practices }

      describe '#lint' do
        subject { rails_best_practices.lint }

        before { stubbings }
        before { subject }

        let(:changed_files) do
          git = rails_best_practices.git
          expect(git).to receive(:modified_files).and_return(modified_files)
          expect(git).to receive(:added_files).and_return(added_files)
        end

        let(:status_reports)    { dangerfile.status_report[:warnings] }
        let(:violation_reports) { dangerfile.violation_report[:warnings] }

        context 'with changed files' do
          let(:modified_files) { ['path/to/file'] }
          let(:added_files)    { [] }

          context 'with lint errors' do
            let(:stubbings) { changed_files && lint_errors }

            let(:lint_errors) do
              linter = ::RailsBestPractices::Analyzer
              errors = [double('Lint Errors', message:     error_message,
                                              filename:    filename,
                                              line_number: line_number)]
              expect_any_instance_of(linter).to receive(:errors)
                .and_return(errors)
            end

            let(:error_message) { 'error message' }
            let(:filename)      { "#{Dir.pwd}/path/to/file" }
            let(:line_number)   { '123' }

            it 'returns warning reports' do
              message   = 'Error message'
              violation = Violation.new(message, false, 'path/to/file', 123)
              expect(status_reports).to eq([message])
              expect(violation_reports).to eq([violation])
            end
          end

          context 'with no lint errors' do
            let(:stubbings) { changed_files }

            it 'returns no warning reports' do
              expect(status_reports).to be_empty
              expect(violation_reports).to be_empty
            end
          end
        end

        describe 'arguments to Analyzer.new' do
          let(:modified_files) { [] }
          let(:added_files)    { [] }

          let(:stubbings) { changed_files }

          let(:analyzer) do
            analyzer = double('Analyzer')
            analyzer.stub(:analyze)
            analyzer.stub(:errors).and_return([])
            analyzer
          end

          describe 'regexp from filenames' do
            let(:modified_files) { ['a.rb'] }
            let(:added_files) { ['b.rb'] }

            it 'escapes correctly' do
              allow(::RailsBestPractices::Analyzer).to receive(:new)
                .with('.', 'silent' => true, 'only' => [/a\.rb/, /b\.rb/])
                .and_return(analyzer)
            end
          end
        end

        context 'with no changed files' do
          let(:stubbings)      { changed_files }
          let(:modified_files) { [] }
          let(:added_files)    { [] }

          it 'returns no warning reports' do
            expect(status_reports).to be_empty
            expect(violation_reports).to be_empty
          end
        end
      end
    end
  end
end
