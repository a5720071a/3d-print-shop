class PrintJobsController < ApplicationController
  def request_jobs
    @orders = Order.where(print_job_generated: false).joins(:payment).where(payments: {status: "Success"})
    @item_list = @orders.joins(:items).select("items.id as item_id").map { |order| order.item_id }
    @items = Item.where id: @item_list
    @jobs = @items.joins(:gcode).select("items.*, gcodes.filename as gcode_filename")
    #@orders.each do |order|
    #  order.print_job_generated = true
    #  order.save!
    #end
    if not @jobs.empty?
      send_data @jobs.to_json, :filename => 'jobs.JSON'
    else
      render status: '200'
    end
  end
end
