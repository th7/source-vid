class Repository < ActiveRecord::Base
  enum status: { inactive: 0, queued: 1, downloading: 2, generating_video: 3, complete: 4 }

  def generate_filename
    uri = URI(url)
    (uri.host + uri.path).gsub('/', '-')
  end
end
