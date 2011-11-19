A patch that provides 'mail' gem with iso-2022-jp conversion capability.
========================================================================

Overview
--------

* (en)

	`mail-iso-2022-jp` is a patch for [mikel/mail](https://github.com/mikel/mail).
	With this patch, you can easily send mails with `ISO-2022-JP` enconding (so-called "JIS-CODE").

* (ja)

    `mail-iso-2022-jp` は、[mikel/mail](https://github.com/mikel/mail) に対するパッチです。
    これを利用すると `ISO-2022-JP`（いわゆる「JISコード」）でのメール送信が容易になります。


Feature
-------

* (en)

    If you set the `charset` header to `ISO-2022-JP`, the values of `From`, `To`, `Cc`, and `Subject` headers
    and the text of body will be automatically converted to `ISO-2022-JP` by `NKF` module.
    
    When the `charset` header has other values, this patch has no effect.

* (ja)

    chasetヘッダの値が `ISO-2022-JP` である場合、送信者(From)、宛先(To)、Cc、件名(Subject)の各ヘッダの値および
    本文(Body)が`NKF`モジュールによって自動的に `ISO-2022-JP` に変換されます。
    
    charsetヘッダの値が `ISO-2022-JP` でない場合、このパッチには何の効果もありません。


Requirements
------------

### Ruby ###

* 1.8.7 or higher

### Gems ###

* `mail` 2.2.5 or higher


Getting Start
-------------

### Install as a gem ###

Add to your Gemfile:

    gem 'mail-iso-2022-jp'

or run this command:

    gem install mail-iso-2022-jp

### Install as a Rails plugin ###

	$ cd RAILS_ROOT
	$ rails plugin install git://github.com/kuroda/mail-iso-2022-jp.git

### Usage ###

    mail = Mail.new(:charset => 'ISO-2022-JP') do
      from    '山田太郎 <taro@example.com>'
      to      '佐藤花子 <hanako@example.com>'
      cc      '事務局 <info@example.com>'
      subject '日本語件名'
      body    '日本語本文'
    end

	mail['from'].encoded
	  => "From: =?ISO-2022-JP?B?GyRCOzNFREJATzobKEI=?= <taro@example.com>\r\n"
	mail['to'].encoded
	  => "To: =?ISO-2022-JP?B?GyRCOjRGIzJWO1IbKEI=?= <hanako@example.com>\r\n"
	mail.subject
	 => "=?ISO-2022-JP?B?GyRCRnxLXDhsN29MPhsoQg==?="
	NKF.nkf('-mw', mail.subject)
	 => "日本語件名"
	mail.body.encoded
	 => "\e$BF|K\\8lK\\J8\e(B"
	NKF.nkf('-w', mail.body.encoded)
	 => "日本語本文"

### Usage with ActionMailer ###

	class UserMailer < ActionMailer::Base
	  default  :charset => 'ISO-2022-JP',
	    :from => "山田太郎 <bar@example.com>",
	    :cc => '事務局 <info@example.com>'

	  def notice
	    mail(:to => '佐藤花子 <foo@example.com>', :subject => '日本語件名') do |format|
	      format.text { render :inline => '日本語本文' }
	    end
	  end
	end


License
-------

(en) `mail-iso-2022-jp` is distributed under the MIT license. ([MIT-LICENSE](https://github.com/kuroda/mail-iso-2022-jp/blob/master/MIT-LICENSE))

(ja) `mail-iso-2022-jp` はMITライセンスで配布されています。 ([MIT-LICENSE](https://github.com/kuroda/mail-iso-2022-jp/blob/master/MIT-LICENSE))


Special thanks
--------------

[Kohei Matsushita](https://github.com/ma2shita) -- Initial creator of this patch.
