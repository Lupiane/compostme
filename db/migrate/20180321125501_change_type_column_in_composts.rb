class ChangeTypeColumnInComposts < ActiveRecord::Migration[5.1]
  def change
    remove_column :composts, :type
    add_column :composts, :public, :boolean, default: false
  end
end
