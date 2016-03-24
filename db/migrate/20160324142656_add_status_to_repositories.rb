class AddStatusToRepositories < ActiveRecord::Migration
  def change
    change_table :repositories do |t|
      t.integer :status, default: 0
    end
  end
end
