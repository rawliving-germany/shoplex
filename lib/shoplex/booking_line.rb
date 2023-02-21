module Shoplex
  BookingLine = Struct.new(:sending_account, :receiving_account, :gross_amount,
                           :reference,
                           :type,
                           :booking,
                           keyword_init:true)

  module BookingLine::Types
    GROSS = :gross
    TAX00 = :tax00
    TAX07 = :tax07
    TAX19 = :tax19
  end
end
