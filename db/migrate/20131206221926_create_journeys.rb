class CreateJourneys < ActiveRecord::Migration
  def change
    create_table :journeys do |t|
      t.datetime :started_at
      t.datetime :ended_at
      t.text :original_description
      t.string :mode, :null => false
      t.string :bus_route
      t.string :start_name
      t.column :start_point, :point
      t.string :end_name
      t.column :end_point, :point
      t.decimal :distance
      t.decimal :speed
      t.integer :minutes_taken

      t.timestamps
    end

    add_index :journeys, :mode
    add_index :journeys, :bus_route    
    add_index :journeys, :distance
    add_index :journeys, :speed    
    add_index :journeys, :minutes_taken

  end

end
