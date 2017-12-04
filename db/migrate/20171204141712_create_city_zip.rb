class CreateCityZip < ActiveRecord::Migration[5.1]
  def change
    create_table :cities do |t|
      t.integer :zipcode
      t.string :name
    end
  end
end
