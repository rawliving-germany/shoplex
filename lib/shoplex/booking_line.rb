class Shoplex::BookingLine
  attr_accessor :date, :sending_account, :receiving_account, :gross_amount, :reference

  def initialize date:, sending_account:, receiving_account:, gross_amount:, reference:
    @date = date
    @sending_account = sending_account
    @receiving_account = receiving_account
    @gross_amount = gross_amount
    @reference = reference
  end
end
