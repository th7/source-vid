require 'open3'

class VideoAdapter
  def initialize(path_to_repo)
    @path_to_repo = path_to_repo
  end

  # mocked for now
  # the command below doesn't seem to terminate
  # and stopping it programmatically doesn't seem to work
  def write_to(output_path)
    FileUtils.cp('/tmp/gource-mocked.mp4', output_path)
  end

  private

  def actual_write_to(output_path, timeout=3)
    cmd = "gource -640x480 -o - #{@path_to_repo} | ffmpeg -y -r 60 -f image2pipe -vcodec ppm -i - -vcodec libx264 -preset ultrafast -pix_fmt yuv420p -crf 1 -threads 0 -bf 0 #{output_path}"
    Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thread|
      set_timeout(wait_thread.pid, timeout)
      stdin.close
      wait_thread.join
    end
  end
  # it seems possible to interrupt gource / ffmpeg gracefully using ctrl+c on a foreground process
  # this creates a working if shorter video
  # this method was intended to programmatically do the same thing
  # but the process doesn't seem to respond
  # and using exa. QUIT seems to produce a corrupt video file
  def set_timeout(pid, timeout)
    # pid = wait_thread.pid
    # Thread.new do
    #   sleep timeout
    #   Process.kill('INT', pid)
    # end
  end
end
