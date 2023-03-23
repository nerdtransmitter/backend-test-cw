class AddDatesToReservations < ActiveRecord::Migration[7.0]
  def change
    add_column :reservations, :start_date, :date
    add_column :reservations, :end_date, :date
  end
end
