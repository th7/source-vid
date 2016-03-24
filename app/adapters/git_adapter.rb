class GitAdapter
  class << self
    def working_directory
      '/tmp/repositories'
    end

    def download(url)
      create_working_dir
      raise 'cloning failed' unless system("cd #{working_directory} && git clone #{url}")
    end

    private

    def create_working_dir
      FileUtils.mkdir(working_directory) unless File.directory?(working_directory)
    end
  end
end
