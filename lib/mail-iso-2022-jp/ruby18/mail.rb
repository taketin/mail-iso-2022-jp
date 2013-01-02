# coding: utf-8

# Patches for Mail on Ruby 1.8.7
module Mail
  WAVE_DASH = [0x301c].pack("U")
  FULLWIDTH_TILDE = [0xff5e].pack("U")
  MINUS_SIGN = [0x2212].pack("U")
  FULLWIDTH_HYPHEN_MINUS = [0xff0d].pack("U")
  NKF_OPTIONS = "--oc=CP50220 -xjW --fb-subchar"

  class InvalidEncodingError < StandardError; end
end
