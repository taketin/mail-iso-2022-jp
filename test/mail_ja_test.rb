#coding:utf-8
require 'test_helper'

require 'action_mailer'
require File.dirname(__FILE__) + '/../init'

class MailJaTest < ActiveSupport::TestCase
  test "ISO-2022-JP" do
    mail = Iso2022jpMailer.notice
    assert_equal NKF::JIS, NKF.guess(mail.subject)
    assert_equal "From: =?ISO-2022-JP?B?GyRCOzNFREJATzobKEI=?= <bar@example.com>\r\n", mail[:from].encoded
    assert_equal "To: =?ISO-2022-JP?B?GyRCOjRGIzJWO1IbKEI=?= <foo@example.com>\r\n", mail[:to].encoded
    assert_equal "Subject: =?ISO-2022-JP?B?GyRCRnxLXDhsN29MPhsoQg==?=\r\n", mail[:subject].encoded
    assert_equal NKF::JIS, NKF.guess(mail.body.encoded)
  end

  test "ORIGIN" do
    mail = OriginMailer.notice
    assert_equal NKF::UTF8, NKF.guess(mail.subject)
    assert_equal "From: =?UTF-8?B?5bGx55Sw5aSq6YOO?= <bar@example.com>\r\n", mail[:from].encoded
    assert_equal "To: =?UTF-8?B?5L2Q6Jek6Iqx5a2Q?= <foo@example.com>\r\n", mail[:to].encoded
    assert_equal "Subject: =?UTF-8?Q?=E6=97=A5=E6=9C=AC=E8=AA=9E=E4=BB=B6=E5=90=8D?=\r\n", mail[:subject].encoded
    assert_equal NKF::UTF8, NKF.guess(mail.body.encoded)
  end
end

class Iso2022jpMailer < ActionMailer::Base
  default :from => "山田太郎 <bar@example.com>", :charset => 'ISO-2022-JP'
  def notice
    mail(:to => '佐藤花子 <foo@example.com>', :subject => '日本語件名') do |format|
      format.text { render :inline => '日本語本文' }
    end
  end
end

class OriginMailer < ActionMailer::Base
  default :from => "山田太郎 <bar@example.com>"
  def notice
    mail(:to => '佐藤花子 <foo@example.com>', :subject => '日本語件名') do |format|
      format.text { render :inline => '日本語本文' }
    end
  end
end
