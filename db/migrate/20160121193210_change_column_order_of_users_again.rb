class ChangeColumnOrderOfUsersAgain < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.change :created_at, :datetime, after: :postal_code
      t.change :updated_at, :datetime, after: :created_at
    end
  end
end
