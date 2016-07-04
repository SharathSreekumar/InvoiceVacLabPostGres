class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.string :customer_name
      t.integer :customer_phone, limit: 8
      t.string :customer_email
      t.string :invoice
      t.timestamp :invoice_date
      t.string :product
      t.float :rate
      t.integer :quantity
      t.float :amount

      t.timestamps null: false
    end
  end
end
