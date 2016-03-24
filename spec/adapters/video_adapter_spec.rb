RSpec.describe VideoAdapter do
  describe('#write_to') do
    let(:adapter) { VideoAdapter.new('/fake/path/to/repo') }

    it 'calls the expected system command' do
      expect(adapter).to receive(:system).with('cd /fake/path/to/repo && gource -1280x720 -o - | ffmpeg -y -r 60 -f image2pipe -vcodec ppm -i - -vcodec libx264 -preset ultrafast -pix_fmt yuv420p -crf 1 -threads 0 -bf 0 /fake/path/to/file.mp4').and_return(true)
      adapter.write_to('/fake/path/to/file.mp4')
    end
  end
end
