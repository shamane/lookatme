class Token
  def self.generate
    (0..24).map{ (65 + rand(26)).chr.downcase }.join
  end
end
