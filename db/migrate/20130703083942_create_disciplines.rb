class CreateDisciplines < ActiveRecord::Migration
  def change
    create_table :disciplines do |t|
      t.string :name
      t.text :description
      t.references :user
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.timestamps
    end
  end
end
