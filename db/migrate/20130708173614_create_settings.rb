class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :state
    end
  end
end
