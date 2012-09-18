class CreateSpentTimes < ActiveRecord::Migration
  def change
    create_table :spent_times do |t|
      t.integer :time
      t.integer :activity_id

      t.timestamps
    end
  end
end
