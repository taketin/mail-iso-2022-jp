if RUBY_VERSION >= '1.9'
  require 'mail-iso-2022-jp/mail'
else
  require 'mail-iso-2022-jp/ruby18/mail'
end
require 'mail-iso-2022-jp/patches'
