class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :title
      t.text :message
      t.integer :sender
      t.integer :receiver
      t.boolean :hasread

      t.timestamps
    end
  end
end
