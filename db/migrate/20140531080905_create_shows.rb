class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.references :card, index: true
      t.timestamp :shown_at
    end
  end
end
