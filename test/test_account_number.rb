# frozen_string_literal: true

require "test_helper"

class TestAccountNumber < Minitest::Test
  def test_that_it_gets_receiver_right
    assert_equal 10100, Shoplex::AccountNumber::sending_gross(lastname: 'Busch')
    assert_equal 11200, Shoplex::AccountNumber::sending_gross(lastname: 'Margin')
    assert_equal 12100, Shoplex::AccountNumber::sending_gross(lastname: 'Verhoyn')
  end

  def test_that_it_ignores_casing
    account_number = -> (name) {Shoplex::AccountNumber.sending_gross(lastname: name)}
    assert_equal account_number['Chris'], account_number['chris']
    assert_equal account_number['zynk'], account_number['Zynk']
  end

  def test_that_it_gets_umlaut_receiver_right
    assert_equal 10100, Shoplex::AccountNumber::sending_gross(lastname: 'Ümasch')
  end

  def test_that_it_raises_on_weird_chars
    assert_raises do
      Shoplex::AccountNumber::sending_gross(lastname: 'Úmasch')
    end
  end
end
