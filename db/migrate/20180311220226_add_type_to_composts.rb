class AddTypeToComposts < ActiveRecord::Migration[5.1]
  def change
    add_column :composts, :type, :string
  end
end
