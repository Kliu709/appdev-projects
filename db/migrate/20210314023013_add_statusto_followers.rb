class AddStatustoFollowers < ActiveRecord::Migration[6.0]
  def change
    add_column :followers, :status, :boolean
  end
end
