# frozen_string_literal: true

require "test_helper"

class TestAccountNumber < Minitest::Test
  def test_that_it_gets_receiver_right
    assert_equal 10100, Shoplex::AccountNumber::sending_gross(lastname: 'Busch')
    assert_equal 11200, Shoplex::AccountNumber::sending_gross(lastname: 'Margin')
    assert_equal 12100, Shoplex::AccountNumber::sending_gross(lastname: 'Verhoyn')
  end

  def test_that_it_reencodes
    account_number = -> (name) {Shoplex::AccountNumber.sending_gross(lastname: name)}
    assert_equal account_number["Üma".encode(Encoding::ISO_8859_1)], account_number['Ümat']
  end

  def test_that_it_ignores_casing
    account_number = -> (name) {Shoplex::AccountNumber.sending_gross(lastname: name)}
    assert_equal account_number['Chris'], account_number['chris']
    assert_equal account_number['zynk'], account_number['Zynk']
  end

  def test_that_it_gets_umlaut_receiver_right
    assert_equal 12000, Shoplex::AccountNumber::sending_gross(lastname: 'Ümasch')
  end

  def test_that_it_strips_lastnames
    assert_equal 11200, Shoplex::AccountNumber::sending_gross(lastname: '   Margin')
  end

  def test_that_it_raises_on_weird_chars
    assert_raises do
      Shoplex::AccountNumber::sending_gross(lastname: 'Ú')
    end
  end

  def test_that_it_looks_for_first_ascii_char
    assert_equal Shoplex::AccountNumber::sending_gross(lastname: 'Matz'),
                 Shoplex::AccountNumber::sending_gross(lastname: ' & Matz')
  end

  def test_that_12300_is_max_special_handling
    ['Xylith', 'Ygman', 'Zoltosh'].each do |one_two_three|
      assert_equal 12300, Shoplex::AccountNumber::sending_gross(lastname: one_two_three)
    end
  end
end
