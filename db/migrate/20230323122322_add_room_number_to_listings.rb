class AddRoomNumberToListings < ActiveRecord::Migration[7.0]
  def change
    add_column :listings, :num_rooms, :integer
  end
end
