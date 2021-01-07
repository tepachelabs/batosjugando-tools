class CreateJuegathonEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :juegathon_events do |t|
      t.string :name
      t.datetime :start_datetime
      t.datetime :end_datetime
      t.decimal :total_donation, precision: 10, scale: 2

      t.timestamps
    end
  end
end
