require 'rails_helper'

RSpec.describe Api::V1::InvoiceItems::FindController, type: :controller do
  render_views

  describe "find a single invoice_item when multiple invoice_items exist" do
    it 'finds an invoice_item by id' do
      invoice_items = create_list(:invoice_item, 3)

      get :show, params: {id: invoice_items[0].id, format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to eq(invoice_items[0].id)
      expect(result["item_id"]).to eq(invoice_items[0].item_id)
      expect(result["invoice_id"]).to eq(invoice_items[0].invoice_id)
      expect(result["quantity"]).to eq(invoice_items[0].quantity)
      expect(result["unit_price"]).to eq("150.50")
      expect(result["created_at"]).to eq(nil)
      expect(result["updated_at"]).to eq(nil)
    end

    it 'finds an invoice_item by item_id' do
      invoice_items = create_list(:invoice_item, 3)

      get :show, params: {item_id: invoice_items[1].item_id, format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to eq(invoice_items[1].id)
      expect(result["item_id"]).to eq(invoice_items[1].item_id)
      expect(result["invoice_id"]).to eq(invoice_items[1].invoice_id)
      expect(result["quantity"]).to eq(invoice_items[1].quantity)
      expect(result["unit_price"]).to eq("150.50")
      expect(result["created_at"]).to eq(nil)
      expect(result["updated_at"]).to eq(nil)
    end

    it 'finds an invoice_item by invoice_id' do
      invoice_items = create_list(:invoice_item, 3)

      get :show, params: {invoice_id: invoice_items[2].invoice_id, format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to eq(invoice_items[2].id)
      expect(result["item_id"]).to eq(invoice_items[2].item_id)
      expect(result["invoice_id"]).to eq(invoice_items[2].invoice_id)
      expect(result["quantity"]).to eq(invoice_items[2].quantity)
      expect(result["unit_price"]).to eq("150.50")
      expect(result["created_at"]).to eq(nil)
      expect(result["updated_at"]).to eq(nil)
    end

    it 'finds an invoice_item by unit_price' do
      invoice_items = create_list(:invoice_item, 2)
      uniq_price_invoice_item = create(:invoice_item, unit_price: 1050)

      get :show, params: {unit_price: 10.50, format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to eq(uniq_price_invoice_item.id)
      expect(result["item_id"]).to eq(uniq_price_invoice_item.item_id)
      expect(result["invoice_id"]).to eq(uniq_price_invoice_item.invoice_id)
      expect(result["quantity"]).to eq(uniq_price_invoice_item.quantity)
      expect(result["unit_price"]).to eq("10.50")
      expect(result["created_at"]).to eq(nil)
      expect(result["updated_at"]).to eq(nil)
    end

    it 'returns the first of several invoice_items with the same price' do
      invoice_items = create_list(:invoice_item, 3)

      get :show, params: {unit_price: 150.50, format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to eq(invoice_items[0].id)
      expect(result["id"]).not_to eq(invoice_items[1].id)
    end


    it 'finds an invoice_item by quantity' do
      invoice_items = create_list(:invoice_item, 2)
      uniq_quantity_invoice_item = create(:invoice_item, quantity: 15)

      get :show, params: {quantity: uniq_quantity_invoice_item.quantity, format: :json}
      result = JSON.parse(response.body)

      expect(result["id"]).to eq(uniq_quantity_invoice_item.id)
      expect(result["item_id"]).to eq(uniq_quantity_invoice_item.item_id)
      expect(result["invoice_id"]).to eq(uniq_quantity_invoice_item.invoice_id)
      expect(result["quantity"]).to eq(15)
      expect(result["unit_price"]).to eq("150.50")
      expect(result["created_at"]).to eq(nil)
      expect(result["updated_at"]).to eq(nil)
    end
  end
end
