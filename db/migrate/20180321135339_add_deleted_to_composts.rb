class AddDeletedToComposts < ActiveRecord::Migration[5.1]
  def change
    add_column :composts, :deleted, :boolean, default: false
  end
end
