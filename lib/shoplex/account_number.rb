class Shoplex::AccountNumber
  def self.sending_gross(lastname:)
    char = lastname.upcase.chars.first
    ordinal = char.ord - "A".ord
    10_000 + ordinal * 100
  end

  def self.receiving_tax0(eu:)
  end

  def self.receiving_tax7(eu:)
  end

  def self.receiving_tax19(eu:)
  end
end
