class AddVideoFilepathToRepositories < ActiveRecord::Migration
  def change
    change_table :repositories do |t|
      t.string :video_filepath
    end
  end
end
