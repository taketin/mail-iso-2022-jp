mail-iso-2022-jp
================

A patch that provides 'mail' gem with iso-2022-jp conversion capability.

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

    * If you set the `charset` header to `ISO-2022-JP`, the values of `From`, `Sender`, `To`, `Cc`,
    `Reply-To`, `Subject`, `Resent-From`, `Resent-Sender`, `Resent-To` and `Resent-Cc` headers
    and the text of body will be automatically converted to `ISO-2022-JP`.

    * The text part of multipart mail is also encoded with iso-2022-jp.

    * When the `charset` header has other values, this patch has no effect.

* (ja)

    * chasetヘッダの値が `ISO-2022-JP` である場合、差出人(From)、Sender、宛先(To)、Cc、Reply-To、件名(Subject)、
    Resent-From、Resent-Sender、Resent-To、Resent-Cc の各ヘッダの値および本文(Body)が
    自動的に `ISO-2022-JP` に変換されます。

    * マルチパートメールのテキストパートもiso-2022-jpでエンコードされます。

    * charsetヘッダの値が `ISO-2022-JP` でない場合、このパッチには何の効果もありません。

Requirements
------------

### Ruby ###

* 1.8.7, 1.9.x, 2.0.0-preview2

### Gems ###

* `mail` 2.2.6 or higher, but lower than or equal to 2.5.3

### ActionMailer (Optional) ###

* 3.0 or higher


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


Remarks
-------

* (en)
    * NEC special characters like `①` and IBM extended characters like `髙`, `﨑`
    are allowed in the subject, recipient names and mail body.
    * Fullwidth tildes (U+FF5E) are translated into wave dashes (U+301C).
    * Half-width (Hankaku) katakanas are maintained intact.
    * Characters that cannot be translated into iso-2022-jp encoding are substituted with question marks (`?`).

* (ja)
    * `①` などのNEC特殊文字や `髙` や `﨑` といったIBM拡張文字を件名、宛先、本文などに含めることができます。
    * 全角チルダ(U+FF5E)は波ダッシュ(U+301C)に変換されます。
    * 半角カタカナはそのまま維持されます。
    * 変換できない文字は疑問符(`?`)で置換されます。

References
----------

* http://d.hatena.ne.jp/fujisan3776/20110628/1309255427
* http://d.hatena.ne.jp/rudeboyjet/20100605/p1
* http://d.hatena.ne.jp/hichiriki/20101026#1288107706
* http://d.hatena.ne.jp/deeeki/20111003/rails3_mailer_iso2022jp
* http://d.hatena.ne.jp/tmtms/20090611/1244724573

License
-------

(en) `mail-iso-2022-jp` is distributed under the MIT license. ([MIT-LICENSE](https://github.com/kuroda/mail-iso-2022-jp/blob/master/MIT-LICENSE))

(ja) `mail-iso-2022-jp` はMITライセンスで配布されています。 ([MIT-LICENSE](https://github.com/kuroda/mail-iso-2022-jp/blob/master/MIT-LICENSE))


Special thanks
--------------

[Kohei Matsushita](https://github.com/ma2shita) -- Initial creator of this patch.
