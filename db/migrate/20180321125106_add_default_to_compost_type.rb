class AddDefaultToCompostType < ActiveRecord::Migration[5.1]
  def change
    change_column_default :composts, :type, "Private"
  end
end
