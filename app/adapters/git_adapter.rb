require 'securerandom'

class GitAdapter
  class << self
    def working_directory
      '/tmp/repositories'
    end

    def with_downloaded(url)
      create_working_dir
      repo_path = File.join(working_directory, SecureRandom.uuid)
      raise 'cloning failed' unless system("cd #{working_directory} && git clone #{url} #{repo_path}")
      begin
        yield repo_path
      ensure
        FileUtils.rm_rf(repo_path)
      end
    end

    private

    def create_working_dir
      FileUtils.mkdir(working_directory) unless File.directory?(working_directory)
    end
  end
end
