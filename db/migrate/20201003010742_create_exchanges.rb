class CreateExchanges < ActiveRecord::Migration[6.0]
  def change
    create_table :exchanges do |t|
      t.text :description
      t.float :amount
    end
  end
end
