# frozen_string_literal: true

require "test_helper"

class TestShopwareCSVParser < Minitest::Test

  def test_it_provides_processing_statistics
    shopware_csv_file = File.read('test/files/two_lines_one_invoice_shopware.csv', encoding: Encoding::ISO_8859_1)
    result = Shoplex::ShopwareCSVParser.parse shopware_csv_file

    assert_equal 1, result.valid_invoices
    assert_equal 1, result.invalid_invoices
  end

  def test_it_creates_shopware_invoice_objects
    shopware_csv_file = File.read('test/files/two_lines_one_invoice_shopware.csv', encoding: Encoding::ISO_8859_1)
    result = Shoplex::ShopwareCSVParser.parse shopware_csv_file

    assert_equal 1, result.invoices.count
    assert_equal Shoplex::ShopwareInvoice, result.invoices.first.class
  end

  def test_it_alerts_if_weird_taxes_are_set
    #assert false
  end

  def test_it_sets_date_invoice_number_and_order_number
    shopware_csv_file = File.read('test/files/two_lines_one_invoice_shopware.csv', encoding: Encoding::ISO_8859_1)
    result = Shoplex::ShopwareCSVParser.parse shopware_csv_file
    invoice = result.invoices.first
    assert_equal DateTime.new(2022,10,26,7,7,7), invoice.order_time
    assert_equal '6010', invoice.invoice_number
    assert_equal '90067', invoice.order_number
  end
end

