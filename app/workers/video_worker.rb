class VideoWorker
  include Sidekiq::Worker

  def perform(repository_id)
    repo = Repository.find(repository_id)
    url = repo.url
    GitAdapter.with_downloaded(url) do |repo_path|
      video_filepath = VideoAdapter.new(repo_path).write_to(repo.id, repo.generate_filename)
      repo.update_attributes!(video_filepath: video_filepath)
    end
  end
end
