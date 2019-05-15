class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :role
      t.boolean :active

      # t.timestamps
    end
  end
end
