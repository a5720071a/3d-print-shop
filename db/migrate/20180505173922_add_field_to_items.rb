class AddFieldToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :print_job_generated, :boolean, :default => false
  end
end
