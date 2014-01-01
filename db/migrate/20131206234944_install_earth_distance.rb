class InstallEarthDistance < ActiveRecord::Migration
  def up
    execute "create extension cube"
    execute "create extension earthdistance"    
  end

  def down
    execute "drop extension earthdistance"    
    execute "drop extension cube"   
  end
end
