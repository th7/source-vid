class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.string :url
    end
  end
end
