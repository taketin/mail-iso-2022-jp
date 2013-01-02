# coding: utf-8

require 'mail'
require 'base64'

module Mail
  module FieldWithIso2022JpEncoding
    def self.included(base)
      base.send :alias_method, :initialize_without_iso_2022_jp_encoding, :initialize
      base.send :alias_method, :initialize, :initialize_with_iso_2022_jp_encoding
      base.send :alias_method, :do_decode_without_iso_2022_jp_encoding, :do_decode
      base.send :alias_method, :do_decode, :do_decode_with_iso_2022_jp_encoding
    end

    def initialize_with_iso_2022_jp_encoding(value = nil, charset = 'utf-8')
      if charset.to_s.downcase == 'iso-2022-jp'
        if value.kind_of?(Array)
          value = value.map { |e| encode_with_iso_2022_jp(e, charset) }
        else
          value = encode_with_iso_2022_jp(value, charset)
        end
      end
      initialize_without_iso_2022_jp_encoding(value, charset)
    end

    private
    def do_decode_with_iso_2022_jp_encoding
      if charset.to_s.downcase == 'iso-2022-jp'
        value
      else
        do_decode_without_iso_2022_jp_encoding
      end
    end

    def encode_with_iso_2022_jp(value, charset)
      value = value.to_s.gsub(/#{WAVE_DASH}/, FULLWIDTH_TILDE)
      value = value.to_s.gsub(/#{MINUS_SIGN}/, FULLWIDTH_HYPHEN_MINUS)
      value = Mail.encoding_to_charset(value, charset)
      value.force_encoding('ascii-8bit')
      value = b_value_encode(value)
      value.force_encoding('ascii-8bit')
    end

    def b_value_encode(string)
      string.split(' ').map do |s|
        if s =~ /\e/
          encode64(s)
        else
          s
        end
      end.join(" ")
    end

    private
    def encode(value)
      if charset.to_s.downcase == 'iso-2022-jp'
        value
      else
        super(value)
      end
    end

    def encode_crlf(value)
      if charset.to_s.downcase == 'iso-2022-jp'
        value.force_encoding('ascii-8bit')
      end
      super(value)
    end

    def encode64(string)
      "=?ISO-2022-JP?B?#{Base64.encode64(string).gsub("\n", "")}?="
    end
  end
end
