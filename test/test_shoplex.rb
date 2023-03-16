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

  def test_it_works_for_single_taxed
    input_file_content = File.read('test/files/single_tax_lines.csv', encoding: Encoding::UTF_8)

    result_file_content = Shoplex::process(input_file_content).csv_out

    expected = <<~CSV
     31.10.2022,6130,6130 90196  Smith,49.44,11800,8300,EUR
    CSV

    expected = expected.encode(Encoding::ISO_8859_1,
                     invalid: :replace,
                     undef: :replace,
                     replace: '#').force_encoding(Encoding::ISO_8859_1)

    # -> netto 53,12
    # ->  7: 2,23
    # -> 19: 4,04
    assert_equal expected.strip,
      result_file_content.strip
  end

  def test_it_does_the_whole_shebang
    input_file_content = File.read('test/files/three_invoices_shopware.csv', encoding: Encoding::UTF_8)

    result_file_content = Shoplex::process(input_file_content).csv_out

    expected = <<~CSV
     26.10.2022,6010,6010 90061  TheLastName,59.39,11900,0,EUR
     26.10.2022,6010,6010 90061  TheLastName,33.16,0,8300,EUR
     26.10.2022,6010,6010 90061  TheLastName,26.23,0,8400,EUR
     26.10.2022,6009,6009 90062  Ümläut,95.67,12000,0,EUR
     26.10.2022,6009,6009 90062  Ümläut,95.67,0,8300,EUR
     26.10.2022,6008,6008 90063  Zash,124.49,12500,0,EUR
     26.10.2022,6008,6008 90063  Zash,124.49,0,8300,EUR
    CSV

    expected = expected.encode(Encoding::ISO_8859_1,
                     invalid: :replace,
                     undef: :replace,
                     replace: '#').force_encoding(Encoding::ISO_8859_1)

    # -> netto 53,12
    # ->  7: 2,23
    # -> 19: 4,04
    assert_equal expected.strip,
      result_file_content.strip
  end

  def test_it_catches_errors_and_add_them_to_result
    # Converter errors
    # assert false
  end
end
