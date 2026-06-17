class CreatePurchaseRequests < ActiveRecord::Migration[8.1]
  def change
    create_table :purchase_requests do |t|
      t.string :requester_name
      t.string :item_name
      t.decimal :amount
      t.string :status

      t.timestamps
    end
  end
end
