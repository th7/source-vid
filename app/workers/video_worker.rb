class VideoWorker
  include Sidekiq::Worker

  def perform(repository_id)
    repo = Repository.find(repository_id)
    url = repo.url
    repo.downloading!
    GitAdapter.with_downloaded(url) do |repo_path|
      repo.generating_video!
      video_filepath = VideoAdapter.new(repo_path).write_to(repo.id, repo.generate_filename)
      repo.update_attributes!(video_filepath: video_filepath, status: :complete)
    end
  end
end
