class AddStateToDisciplines < ActiveRecord::Migration
  def change
    add_column :disciplines, :state, :string
  end
end
