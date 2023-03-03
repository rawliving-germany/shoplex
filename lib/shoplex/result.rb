module Shoplex
  class Result
    attr_accessor :valid_invoices, :invalid_invoices
    attr_accessor :invoices

    def initialize
      @valid_invoices, @invalid_invoices = 0 ,0
      @invoices = []
    end
  end
end
