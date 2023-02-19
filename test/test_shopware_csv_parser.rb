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
end

