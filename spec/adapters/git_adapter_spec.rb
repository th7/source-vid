RSpec.describe GitAdapter do

  describe '#clone' do
    context 'given the working directory does not exist' do
      before do
        FileUtils.rm(GitAdapter.working_directory)
      end
    end

    it 'creates the working directory' do
      expect {
        GitAdapter.download('junk_url')
      }.to change {
        File.directory?(GitAdapter.working_directory)
      }.from(false).to(true)
    end
  end
end
