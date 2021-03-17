class AddMediumtoStudyBlocks < ActiveRecord::Migration[6.0]
  def change
    add_column :study_blocks, :medium, :string
  end
end
