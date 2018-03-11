class CreateComposts < ActiveRecord::Migration[5.1]
  def change
    create_table :composts do |t|
      t.string :address
      t.text :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
