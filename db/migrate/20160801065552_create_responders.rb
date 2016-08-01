class CreateResponders < ActiveRecord::Migration
  def change
    create_table :responders do |t|
    	t.integer :inheritance
    	t.string :type
    	t.string :name
    	t.integer :emergency_id
    	t.integer :capacity
    	t.boolean :on_duty
    	t.timestamps null: false
    end

    add_index :responders, :name
    add_index :responders, :emergency_id
    add_index :responders, :type
  end
end
