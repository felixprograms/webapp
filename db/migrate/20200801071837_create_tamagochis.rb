class CreateTamagochis < ActiveRecord::Migration[6.0]
  def change
     create_table :tamagotchis do |t|
	t.string 'name'
	t.integer 'health'
	t.integer 'fun'
     end
  end
end
