# frozen_string_literal: true

require_relative "shoplex/version"
require_relative "shoplex/shopware_csv_parser"

module Shoplex
  class Error < StandardError; end

  def self.process file_content
    return "\n"
  end
end
