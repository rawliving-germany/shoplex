# frozen_string_literal: true

require "test_helper"

class TestShoplex < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Shoplex::VERSION
  end

  def test_it_ignores_lines_without_invoice_number
    result_file_content = Shoplex::process(File.read('test/files/two_lines_one_invoice_shopware.csv', encoding: Encoding::ISO_8859_1))
    assert_equal 3, result_file_content.lines.count
  end

  def test_it_does_the_whole_shebang
    result_file_content = Shoplex::process(File.read('test/files/two_lines_one_invoice_shopware.csv', encoding: Encoding::ISO_8859_1))
    expected = <<~CSV
     26.10.2022,6010,6010 90067  LastNameOfBill,59.39,11100,0,EUR
     26.10.2022,6010,6010 90067  LastNameOfBill,2.23,0,8310,EUR
     26.10.2022,6010,6010 90067  LastNameOfBill,4.04,0,8315,EUR
    CSV
    assert_equal expected.strip,
      result_file_content.strip
  end

  def test_it_catches_errors_and_add_them_to_result
    # Converter errors
    # assert false
  end
end
