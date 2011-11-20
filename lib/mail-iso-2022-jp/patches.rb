# coding:utf-8

class String
  def blank?
    self.force_encoding('ascii-8bit') !~ /\S/
  end
end


module Mail
  WAVE_DASH = "〜" # U+301C
  FULLWIDTH_TILDE = "～" # U+FF5E

  class Message
    def process_body_raw_with_iso_2022_jp_encoding
      if @charset.to_s.downcase == 'iso-2022-jp'
        @body_raw.gsub!(/#{WAVE_DASH}/, FULLWIDTH_TILDE)
        @body_raw = NKF.nkf('--cp932 -j', @body_raw)
      end
      process_body_raw_without_iso_2022_jp_encoding
    end
    alias_method :process_body_raw_without_iso_2022_jp_encoding, :process_body_raw
    alias_method :process_body_raw, :process_body_raw_with_iso_2022_jp_encoding
  end
  
  class Body
    def initialize_with_iso_2022_jp_encoding(string = '')
      if string.respond_to?(:encoding) && string.encoding.to_s == 'ISO-2022-JP'
        string.force_encoding('US-ASCII')
      end
      initialize_without_iso_2022_jp_encoding(string)
    end
    alias_method :initialize_without_iso_2022_jp_encoding, :initialize
    alias_method :initialize, :initialize_with_iso_2022_jp_encoding
  end
  
  module FieldWithIso2022JpEncoding
    def self.included(base)
      base.send :alias_method, :initialize_without_iso_2022_jp_encoding, :initialize
      base.send :alias_method, :initialize, :initialize_with_iso_2022_jp_encoding
      base.send :alias_method, :do_decode_without_iso_2022_jp_encoding, :do_decode
      base.send :alias_method, :do_decode, :do_decode_with_iso_2022_jp_encoding
    end

    def initialize_with_iso_2022_jp_encoding(value = nil, charset = 'utf-8')
      if charset.to_s.downcase == 'iso-2022-jp'
        value.gsub!(/#{WAVE_DASH}/, FULLWIDTH_TILDE)
        value = NKF.nkf('--cp932 -Mj', NKF.nkf('--cp932 -j', value)).gsub("\n", '').strip
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
  end
  
  class SubjectField < UnstructuredField
    include FieldWithIso2022JpEncoding
    
    private
    def encode(value)
      if charset.to_s.downcase == 'iso-2022-jp'
        value
      else
        super(value)
      end
    end
  end

  class FromField < StructuredField
    include FieldWithIso2022JpEncoding
  end

  class SenderField < StructuredField
    include FieldWithIso2022JpEncoding
  end

  class ToField < StructuredField
    include FieldWithIso2022JpEncoding
  end

  class CcField < StructuredField
    include FieldWithIso2022JpEncoding
  end

  class ReplyToField < StructuredField
    include FieldWithIso2022JpEncoding
  end

  class ResentFromField < StructuredField
    include FieldWithIso2022JpEncoding
  end

  class ResentSenderField < StructuredField
    include FieldWithIso2022JpEncoding
  end

  class ResentToField < StructuredField
    include FieldWithIso2022JpEncoding
  end

  class ResentCcField < StructuredField
    include FieldWithIso2022JpEncoding
  end
end
