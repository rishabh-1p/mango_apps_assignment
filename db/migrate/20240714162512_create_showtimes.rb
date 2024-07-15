class CreateShowtimes < ActiveRecord::Migration[6.1]
  def change
    create_table :showtimes do |t|
      t.date :date
      t.time :start_time
      t.time :end_time
      t.references :movie, null: false, foreign_key: true
      t.timestamps
    end
  end
end
