module Shoplex
  class Result
    attr_accessor :invoices
    attr_accessor :errors

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
