class Repository < ActiveRecord::Base
  def generate_filename
    uri = URI(url)
    (uri.host + uri.path).gsub('/', '-')
  end
end
