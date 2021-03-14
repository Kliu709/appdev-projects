class AddDescriptiontoStudyBlocks < ActiveRecord::Migration[6.0]
  def change
    add_column :study_blocks, :description, :string
  end
end
