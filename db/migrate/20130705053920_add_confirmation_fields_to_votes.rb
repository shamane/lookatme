class AddConfirmationFieldsToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :confirmation_token, :string
    add_column :votes, :confirmed_at, :date
  end
end
