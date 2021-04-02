class CreateBulkUploads < ActiveRecord::Migration[6.1]
  def change
    create_table :bulk_uploads do |t|
      t.references :uploader, null: false, foreign_key: {to_table: :users, index: true}

      t.timestamps
    end
  end
end
