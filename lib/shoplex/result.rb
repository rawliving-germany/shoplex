module Shoplex
  class Result
    attr_accessor :invoices
    attr_reader   :errors
    attr_accessor :csv_out

    def initialize
      @invoices = []
      @errors = {}
    end

    def mark_error(maker:, error:, obj:)
      @errors[maker] ||= {}
      @errors[maker][error] ||= []

      @errors[maker][error] << obj
    end
  end
end
