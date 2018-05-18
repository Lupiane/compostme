class AddDefaultPhotoToUsers < ActiveRecord::Migration[5.1]
  def change
    change_column_default :users, :photo, from: :null, to: "image/upload/v1522224406/contact_compostme.app_sfxgka.png"
  end
end
