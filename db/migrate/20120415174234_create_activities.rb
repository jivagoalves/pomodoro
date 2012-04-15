class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :description
      t.boolean :done

      t.timestamps
    end
  end
end
