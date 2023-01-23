# frozen_string_literal: true

class CreateUserAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :user_addresses do |t|
      t.string :zip_code, null: false
      t.string :street
      t.string :complement
      t.string :neighborhood
      t.string :city
      t.string :state
      t.string :ibge
      t.string :gia
      t.string :ddd
      t.string :siafi
      t.string :name, null: false

      t.timestamps
    end

    add_index :user_addresses, %i[zip_code name], unique: true
  end
end
