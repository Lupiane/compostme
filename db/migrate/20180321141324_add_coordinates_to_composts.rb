class AddCoordinatesToComposts < ActiveRecord::Migration[5.1]
  def change
    add_column :composts, :latitude, :float
    add_column :composts, :longitude, :float
  end
end
