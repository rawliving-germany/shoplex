module Shoplex
  BookingLine = Struct.new(:sending_account, :receiving_account, :gross_amount,
                           :reference,
                           :type,
                           :booking,
                           keyword_init:true) do
    def initialize(...)
      super(...)
      raise BookingLine::Types::UnsupportedType.new("BookingLine Type #{type.inspect} not supported") if !BookingLine::Types::contains?(type)
    end
  end

  module BookingLine::Types
    class UnsupportedType < StandardError ; end

    GROSS = :gross
    TAX00 = :tax00
    TAX07 = :tax07
    TAX19 = :tax19

    def self.contains? type
      [GROSS, TAX00, TAX07, TAX19].include? type
    end
  end
end
