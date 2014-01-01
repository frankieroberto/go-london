class AddUniqueIndex < ActiveRecord::Migration
  def change

    add_index :journeys, :started_at, unique: true
  end
end
