# coding: utf-8

# Patches for Mail on Ruby 1.8.7
module Mail
  WAVE_DASH = "〜" # U+301C
  FULLWIDTH_TILDE = "～" # U+FF5E
  MINUS_SIGN = [0x2212].pack("U")
  FULLWIDTH_HYPHEN_MINUS = [0xff0d].pack("U")
  NKF_OPTIONS = "--oc=CP50220 -xjW --fb-subchar"

  class InvalidEncodingError < StandardError; end
end
