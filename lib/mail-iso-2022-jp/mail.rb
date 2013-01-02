# coding: utf-8

# Patches for Mail on Ruby 1.9.3 or above
module Mail
  WAVE_DASH = [0x301c].pack("U")
  FULLWIDTH_TILDE = [0xff5e].pack("U")
  MINUS_SIGN = [0x2212].pack("U")
  FULLWIDTH_HYPHEN_MINUS = [0xff0d].pack("U")
  ENCODE = { 'iso-2022-jp' => Encoding::CP50221 }

  def self.encoding_to_charset(str, charset)
    str.encode(ENCODE[charset.to_s.downcase] || charset, :undef => :replace).force_encoding(charset)
  end

  class InvalidEncodingError < StandardError; end
end
