class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.integer :author_id, null: false
      t.references :post, null: false, foreign_key: true
      t.text :text

      t.timestamps
    end

    add_foreign_key :comments, :users, column: :author_id
  end
end