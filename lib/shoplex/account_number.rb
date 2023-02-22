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

  def self.receiving_tax00(eu:)
    8120
  end

  def self.receiving_tax07(eu:)
    eu ? 8300 : 8310
  end

  def self.receiving_tax19(eu:)
    eu ? 8400 : 8315
  end
end
