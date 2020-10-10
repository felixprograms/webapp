class CreateStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :stocks do |t|
      t.references :exchange
      t.string :ticker
      t.float :stocks
    end
  end
end
