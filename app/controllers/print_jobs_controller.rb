class PrintJobsController < ApplicationController
  def request_jobs
    #change to false
    @orders = Order.where(print_job_generated: true).joins(:payment).where(payments: {status: 'Success'})
    @item_list = @orders.joins(:items).select('items.id as item_id').map { |order| order.item_id }
    @items = Item.where id: @item_list
    @jobs = @items.joins(:gcode).select('items.id as item_id, gcodes.filename as gcode_filename')
    @orders.each do |order|
      order.print_job_generated = true
      order.save!
    end
    respond_to do |format|
      format.json { render json: @jobs.to_json( :only => [:item_id, :gcode_filename]) }
      format.html { redirect_to root_path }
    end
  end
end
