# frozen_string_literal: true

require "test_helper"

class TestShoplex < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Shoplex::VERSION
  end

  def test_it_ignores_lines_without_invoice_number
    result_file_content = Shoplex::process(File.read('test/files/two_lines_one_invoice_shopware.csv', encoding: Encoding::ISO_8859_1))
    assert_equal 1, result_file_content.lines.count
  end
end
