RSpec.describe GitAdapter do

  describe '#with_downloaded' do
    after { FileUtils.rm_rf(GitAdapter.working_directory) }

    context 'given the working directory does not exist' do
      before do
        FileUtils.rm_rf(GitAdapter.working_directory)
        expect(GitAdapter).to receive(:system) do |actual_cmd|
          expect(actual_cmd).to match(/cd \/tmp\/repositories && git clone junk_url \/tmp\/repositories\/.*/)
        end.and_return(true)
      end

      it 'creates the working directory' do
        expect(File.directory?(GitAdapter.working_directory)).to eq false
        GitAdapter.with_downloaded('junk_url') do
          expect(File.directory?(GitAdapter.working_directory)).to eq true
        end
      end
    end

    it 'clones the repository' do
      GitAdapter.with_downloaded('https://github.com/th7/journey-tracker') do |repo_path|
        expect(system("cd #{repo_path} && git status")).to eq true
      end
    end
  end

end
