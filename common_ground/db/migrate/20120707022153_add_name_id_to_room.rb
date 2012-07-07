class AddNameIdToRoom < ActiveRecord::Migration
  def change
    add_column :rooms, :name, :string
    add_column :rooms, :members, :integer
  end
end
