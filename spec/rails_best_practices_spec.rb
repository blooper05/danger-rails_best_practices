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

        before { changed_files }
        before { lint_errors }
        before { subject }

        let(:changed_files) do
          git = rails_best_practices.git
          expect(git).to receive(:modified_files).and_return(modified_files)
          expect(git).to receive(:added_files).and_return(added_files)
        end

        let(:modified_files) { [double('Modified Files')] }
        let(:added_files)    { [double('Added Files')] }

        let(:lint_errors) do
          linter = ::RailsBestPractices::Analyzer
          args   = { message:     double('Message'),
                     filename:    double('Filename'),
                     line_number: double('Line Number') }
          errors = [double('Lint Errors', args)]
          expect_any_instance_of(linter).to receive(:errors)
            .and_return(errors)
        end

        it 'returns warning messages' do
          expect(dangerfile.status_report[:warnings]).to be_present
        end
      end
    end
  end
end
