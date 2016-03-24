class VideoWorker
  include Sidekiq::Worker

  OUTPUT_DIR = Rails.root.join('videos')

  def perform(repository_id)
    repo = Repository.find(repository_id)
    url = repo.url
    intended_filename = repo.generate_filename
    intended_filepath = File.join(OUTPUT_DIR, repo.id.to_s)
    FileUtils.mkdir_p(intended_filepath)
    write_to          = File.join(intended_filepath, intended_filename)
    GitAdapter.with_downloaded(url) do |repo_path|
      VideoAdapter.new(repo_path).write_to(write_to)
      repo.update_attributes!(video_filepath: write_to)
    end
  end
end
