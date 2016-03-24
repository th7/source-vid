class VideoWorker
  include Sidekiq::Worker

  def perform(repository_id)
    repo = Repository.find(repository_id)
    url = repo.url
    GitAdapter.with_downloaded(url) do |repo_path|
      VideoAdapter.new(repo_path).write_to('/tmp/gource.mp4')
    end
  end
end
