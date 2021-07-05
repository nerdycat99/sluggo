class CreatePages < ActiveRecord::Migration[5.0]
  def change
    create_table :pages do |t|
      t.string :long_url
      t.text :short_url
      t.integer :counter, default: 0
      t.timestamps
    end
  end
end
