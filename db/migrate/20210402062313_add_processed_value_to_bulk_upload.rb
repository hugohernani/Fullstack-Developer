class AddProcessedValueToBulkUpload < ActiveRecord::Migration[6.1]
  def change
    add_column :bulk_uploads, :processed_value, :integer, default: 0
  end
end
