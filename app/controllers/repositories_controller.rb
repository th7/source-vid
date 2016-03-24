class RepositoriesController < ApplicationController
  def index
    @repositories = Repository.all
  end

  def show
    @repository = Repository.find(params[:id])
  end

  def download
    path = Repository.find(params[:repository_id]).video_filepath
    send_file(
      path,
      filename: File.basename(path),
      type: "video/mp4"
    )
  end

  def start
    Repository.transaction do
      repo = Repository.lock.find(params[:repository_id])
      if repo.inactive?
        VideoWorker.perform_async(repo.id)
        repo.queued!
      else
        raise 'make me a friendlier error noob!'
      end
    end
    redirect_to repository_path(repo.id)
  end
end
