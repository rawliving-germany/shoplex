# frozen_string_literal: true

require "test_helper"

class TestAccountNumber < Minitest::Test
  def test_that_it_gets_receiver_right
    assert_equal 10100, Shoplex::AccountNumber::sending_gross(lastname: 'Busch', eu: true)
    assert_equal 11200, Shoplex::AccountNumber::sending_gross(lastname: 'Margin', eu: true)
  end
end
