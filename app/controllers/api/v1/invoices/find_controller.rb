class Api::V1::Invoices::FindController < ApplicationController

  def show
    @invoice = Invoice.custom_find_by(invoice_params)
  end

  def index
    @invoices = Invoice.custom_where(invoice_params)
  end

  private

  def invoice_params
    params.permit(:id, :customer_id, :merchant_id, :status, :created_at, :updated_at)
  end
end
