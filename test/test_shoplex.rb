# frozen_string_literal: true

require "test_helper"

class TestShoplex < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Shoplex::VERSION
  end

  def test_it_ignores_lines_without_invoice_number
    input_file_content = File.read('test/files/three_invoices_shopware.csv', encoding: Encoding::UTF_8)
    result_file_content = Shoplex::process(input_file_content).csv_out
    assert_equal 3, result_file_content.lines.count
  end

  def test_it_does_the_whole_shebang
    input_file_content = File.read('test/files/three_invoices_shopware.csv', encoding: Encoding::UTF_8)
    result_file_content = Shoplex::process(input_file_content).csv_out
    expected = <<~CSV
     26.10.2022,6010,6010 90067  LastNameOfBill,59.39,11100,0,EUR
     26.10.2022,6010,6010 90067  LastNameOfBill,2.23,0,8300,EUR
     26.10.2022,6010,6010 90067  LastNameOfBill,4.04,0,8400,EUR
    CSV
    assert_equal expected.strip,
      result_file_content.strip
  end

  def test_it_catches_errors_and_add_them_to_result
    # Converter errors
    # assert false
  end
end
