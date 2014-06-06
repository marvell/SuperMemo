class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :front_side
      t.text :back_side

      t.timestamps
    end
  end
end
