class AddUserIdToExchanges < ActiveRecord::Migration[6.0]
  def change
		add_reference :exchanges, :user, index: true
  end
end
