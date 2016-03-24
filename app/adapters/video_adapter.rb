class VideoAdapter
  def initialize(path_to_repo)
    @path_to_repo = path_to_repo
  end

  def write_to(output_path)
    cmd = "cd #{@path_to_repo} && gource -1280x720 -o - | ffmpeg -y -r 60 -f image2pipe -vcodec ppm -i - -vcodec libx264 -preset ultrafast -pix_fmt yuv420p -crf 1 -threads 0 -bf 0 #{output_path}"
    puts cmd
    raise 'could not create video' unless system(cmd)
  end
end
