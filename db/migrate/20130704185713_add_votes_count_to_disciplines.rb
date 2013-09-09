class AddVotesCountToDisciplines < ActiveRecord::Migration
  def change
    add_column :disciplines, :votes_count, :integer, :default => 0
  end
end
