class CreateZombies < ActiveRecord::Migration[6.0]
  def change
    create_table :zombies do |t|
	t.string :name
	t.integer :healthpoints
    end 
  end
end
