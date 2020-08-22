class AddSessionHashToUser < ActiveRecord::Migration[6.0]
  def change
     add_column :users, :session_hash, :string  
  end
end
