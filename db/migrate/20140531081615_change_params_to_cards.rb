class ChangeParamsToCards < ActiveRecord::Migration
  def change
    change_column :cards, :front_side, :string, :null => false
  end
end
