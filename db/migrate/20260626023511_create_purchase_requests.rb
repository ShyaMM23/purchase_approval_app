class CreatePurchaseRequests < ActiveRecord::Migration[8.1]
  def change
    create_table :purchase_requests do |t|
      t.string :title
      t.text :description
      t.decimal :amount
      t.integer :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
