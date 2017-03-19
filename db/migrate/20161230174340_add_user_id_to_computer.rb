class AddUserIdToComputer < ActiveRecord::Migration[5.0]
  def change
    add_column :computers, :user_id, :integer
  end
end
