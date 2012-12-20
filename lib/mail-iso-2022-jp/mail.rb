# coding: utf-8

# Patches for Mail on Ruby 1.9.3 or above
module Mail
  WAVE_DASH = "〜" # U+301C
  FULLWIDTH_TILDE = "～" # U+FF5E
  ENCODE = { 'iso-2022-jp' => Encoding::CP50221 }

  def self.encoding_to_charset(str, charset)
    str.encode(ENCODE[charset.to_s.downcase] || charset, :undef => :replace).force_encoding(charset)
  end

  class InvalidEncodingError < StandardError; end
end
