class AddFieldToShows < ActiveRecord::Migration
  def change
    add_column :shows, :remembered, :boolean
  end
end
