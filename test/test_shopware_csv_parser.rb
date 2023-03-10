# frozen_string_literal: true

require "test_helper"

class TestShopwareCSVParser < Minitest::Test

  def test_it_provides_processing_statistics
    shopware_csv_file = File.read('test/files/three_invoices_shopware.csv', encoding: Encoding::UTF_8)
    result = Shoplex::ShopwareCSVParser.parse shopware_csv_file

    assert_equal 3, result.invoices.count
    assert_equal 1, result.errors.count
  end

  def test_it_creates_shopware_invoice_objects
    shopware_csv_file = File.read('test/files/three_invoices_shopware.csv', encoding: Encoding::ISO_8859_1)
    result = Shoplex::ShopwareCSVParser.parse shopware_csv_file

    assert_equal 3, result.invoices.count
    assert_equal Shoplex::ShopwareInvoice, result.invoices.first.class
  end

  def test_it_alerts_if_weird_taxes_are_set
    #assert false
  end

  def test_it_sets_date_invoice_number_and_order_number
    shopware_csv_file = File.read('test/files/three_invoices_shopware.csv', encoding: Encoding::ISO_8859_1)
    result = Shoplex::ShopwareCSVParser.parse shopware_csv_file
    invoice = result.invoices.first

    assert_equal DateTime.new(2022,10,26,0,0,0), invoice.order_time
    assert_equal '6010', invoice.invoice_number
    assert_equal '90061', invoice.order_number
  end

  # lets go in packs of three, can merge the examples later
  def test_it_sets_amount_and_lastname
    shopware_csv_file = File.read('test/files/three_invoices_shopware.csv', encoding: Encoding::UTF_8)
    result = Shoplex::ShopwareCSVParser.parse shopware_csv_file
    invoice = result.invoices.first

    assert_equal 59.39, invoice.invoice_amount
    assert_equal "TheLastname", invoice.lastname
  end

  def test_it_converts_string_float_columns_correctly
    input = <<~CSV
      "Dokument ID";"Bestellnummer";"...";"Nettobetrag";"Brutto Versandkosten";"...";"Bruttobetrag 7%";"Bruttobetrag 19%"
      87150        ;           6010;     ;        59,39;                 53,12;     ;             4,95;             4,43
    CSV
    result = Shoplex::ShopwareCSVParser.parse input
    assert_equal Float, result.invoices.first.tax07_amount.class
    assert_equal Float, result.invoices.first.tax19_amount.class
    assert_equal Float, result.invoices.first.shipping_gross.class
    assert_equal 4.95, result.invoices.first.tax07_amount
    assert_equal 4.43, result.invoices.first.tax19_amount
  end

  def test_it_sets_country_correctly
    shopware_csv_file = File.read('test/files/three_invoices_shopware.csv', encoding: Encoding::ISO_8859_1)
    result = Shoplex::ShopwareCSVParser.parse shopware_csv_file
    invoice = result.invoices.first

    assert_equal "DE", invoice.country
  end

  def test_it_catches_errors_and_add_them_to_result
    # assert false
  end
end

