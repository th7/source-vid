class GitAdapter
  class << self
    def working_directory
      Rails.root.join('repositories')
    end

    def download(url)
      create_working_dir
    end

    private

    def create_working_dir
      FileUtils.mkdir(working_directory) unless File.directory?(working_directory)
    end
  end
end
