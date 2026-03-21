class CreateTickets < ActiveRecord::Migration[8.1]
  def change
    create_table :tickets do |t|
      t.string :subject, null: false
      t.text :description, null: false
      t.integer :category, default: 0, null: false
      t.integer :priority, default: 0, null: false
      t.integer :status, default: 0, null: false
      t.references :requester, null: false, foreign_key: {to_table: :users}
      t.string :assigned_to

      t.timestamps
    end

    # For faster admin filtering
    add_index :tickets, :status
    add_index :tickets, :priority
    add_index :tickets, :category
  end
end
