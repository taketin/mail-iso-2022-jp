# coding: utf-8

module Mail
  WAVE_DASH = [0x301c].pack("U")
  FULLWIDTH_TILDE = [0xff5e].pack("U")
  MINUS_SIGN = [0x2212].pack("U")
  FULLWIDTH_HYPHEN_MINUS = [0xff0d].pack("U")
end
