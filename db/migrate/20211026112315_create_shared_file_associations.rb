class CreateSharedFileAssociations < ActiveRecord::Migration[6.1]
  def change
    create_table :shared_file_associations do |t|
      t.integer :file_id
      t.integer :shared_user_id
      t.integer :user_id
      t.timestamps
    end
    add_index :shared_file_associations, %i[user_id file_id]
    add_index :shared_file_associations, :user_id
  end
end
