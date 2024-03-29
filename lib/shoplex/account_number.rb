class Shoplex::AccountNumber
  def self.sending_gross(lastname:)
    char = lastname.encode(Encoding::UTF_8).strip.upcase[/[a-zA-ZÖÄÜ]/].chars.first
    char.gsub!(/[ÖÜÄ]/, 'Ä' => 'A', 'Ö' => 'O', 'Ü' => 'U')
    char.gsub!(/[YZ]/, 'X') # capped at 12_300

    if char !~ /[A-Z]/
      raise ArgumentError, "Don't know account number for #{lastname} (does not start with a 'good' letter A-Z)"
    end

    ordinal = char.ord - "A".ord

    10_000 + ordinal * 100
  end


  # 8120 is e.g. Swiss and taxfree - book manually
  # 8125 would be EU with tax-ID-Nr. §4 - book manually
  def self.receiving_tax00(german:)
    8120
  end

  def self.receiving_tax07(german:)
    german ? 8300 : 8310
  end

  def self.receiving_tax19(german:)
    german ? 8400 : 8315
  end
end
