RSpec.describe VideoWorker do
  describe '#perform' do
    it 'produces the expected video file' do
      FileUtils.rm_rf('/tmp/gource.mp4')
      repo = Repository.create(url: 'https://github.com/th7/journey-tracker')
      VideoWorker.new.perform(repo.id)
      expect(File.exists?(repo.reload.video_filepath)).to eq true
    end
  end
end
