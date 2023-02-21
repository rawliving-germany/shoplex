class Shoplex::AccountNumber
  def self.sending_gross(lastname:)
    char = lastname.strip.upcase.chars.first
    char.gsub!(/[ÖÜÄ]/, 'Ä' => 'A', 'Ö' => 'O', 'Ü' => 'U')

    if char !~ /[A-Z]/
      raise ArgumentError, "Don't know account number for #{lastname} (does not start with A-Z)"
    end

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
