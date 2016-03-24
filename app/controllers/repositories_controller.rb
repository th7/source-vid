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
end
