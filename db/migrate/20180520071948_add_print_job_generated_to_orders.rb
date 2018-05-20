class AddPrintJobGeneratedToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :print_job_generated, :boolean, default: false
  end
end
