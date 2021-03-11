class CreateStudyBlocks < ActiveRecord::Migration[6.0]
  def change
    create_table :study_blocks do |t|
      t.time :start_time
      t.time :end_time
      t.string :day_of_week
      t.integer :user_id
      t.string :effort

      t.timestamps
    end
  end
end
