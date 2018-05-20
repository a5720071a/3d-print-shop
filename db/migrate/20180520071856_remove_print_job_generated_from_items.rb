class RemovePrintJobGeneratedFromItems < ActiveRecord::Migration[5.1]
  def change
    remove_column :items, :print_job_generated, :boolean
  end
end
