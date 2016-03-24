RSpec.describe GitAdapter do

  describe '#clone' do
    after { FileUtils.rm_rf(GitAdapter.working_directory) }

    context 'given the working directory does not exist' do
      before do
        FileUtils.rm_rf(GitAdapter.working_directory)
        expect(GitAdapter).to receive(:system).with('cd /tmp/repositories && git clone junk_url').and_return(true)
      end

      it 'creates the working directory' do
        expect {
          GitAdapter.download('junk_url')
        }.to change {
          File.directory?(GitAdapter.working_directory)
        }.from(false).to(true)
      end
    end

    it 'clones the repository' do
      expect {
        GitAdapter.download('https://github.com/th7/journey-tracker')
      }.to change {
        system("cd #{GitAdapter.working_directory}/journey-tracker && git status")
      }.from(false).to(true)
    end
  end

end
