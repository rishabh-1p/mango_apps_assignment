class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :name
      t.string :description
      t.string :genre
      t.datetime :release_date
      t.string :language
      t.timestamps
    end
  end
end
