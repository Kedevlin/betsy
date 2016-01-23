class ChangeColumnOrderOfUsers < ActiveRecord::Migration
  def change
    change_column :users, :created_at, :datetime, after: :postal_code
    change_column :users, :updated_at, :datetime, after: :postal_code
  end
end
