class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :name
      t.string :description
      t.string :status
      t.integer :code
      t.integer :level
      t.string :device_type
      t.integer :type_id
      t.string :brand
      t.string :devid
      t.integer :room_id
      t.integer :property_id

      t.timestamps null: false
    end
  end
end
