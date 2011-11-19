#coding:utf-8
require 'test_helper'

require File.dirname(__FILE__) + '/../init'

class MailTest < ActiveSupport::TestCase
  test "should send with ISO-2022-JP encoding" do
    mail = Mail.new(:charset => 'ISO-2022-JP') do
      from '山田太郎 <taro@example.com>'
      to '佐藤花子 <hanako@example.com>'
      cc '事務局 <info@example.com>'
      subject '日本語件名'
      body '日本語本文'
    end
    assert_equal 'ISO-2022-JP', mail.charset
    assert_equal NKF::JIS, NKF.guess(mail.subject)
    assert_equal "From: =?ISO-2022-JP?B?GyRCOzNFREJATzobKEI=?= <taro@example.com>\r\n", mail[:from].encoded
    assert_equal "To: =?ISO-2022-JP?B?GyRCOjRGIzJWO1IbKEI=?= <hanako@example.com>\r\n", mail[:to].encoded
    assert_equal "Cc: =?ISO-2022-JP?B?GyRCO3ZMMzZJGyhC?= <info@example.com>\r\n", mail[:cc].encoded
    assert_equal "Subject: =?ISO-2022-JP?B?GyRCRnxLXDhsN29MPhsoQg==?=\r\n", mail[:subject].encoded
    assert_equal NKF::JIS, NKF.guess(mail.body.encoded)
  end

  test "should send with UTF-8 encoding" do
    mail = Mail.new do
      from '山田太郎 <taro@example.com>'
      to '佐藤花子 <hanako@example.com>'
      cc '事務局 <info@example.com>'
      subject '日本語件名'
      body '日本語本文'
    end
    assert_equal 'UTF-8', mail.charset
    assert_equal NKF::UTF8, NKF.guess(mail.subject)
    assert_equal "From: =?UTF-8?B?5bGx55Sw5aSq6YOO?= <taro@example.com>\r\n", mail[:from].encoded
    assert_equal "To: =?UTF-8?B?5L2Q6Jek6Iqx5a2Q?= <hanako@example.com>\r\n", mail[:to].encoded
    assert_equal "Cc: =?UTF-8?B?5LqL5YuZ5bGA?= <info@example.com>\r\n", mail[:cc].encoded
    assert_equal "Subject: =?UTF-8?Q?=E6=97=A5=E6=9C=AC=E8=AA=9E=E4=BB=B6=E5=90=8D?=\r\n", mail[:subject].encoded
    assert_equal NKF::UTF8, NKF.guess(mail.body.encoded)
  end
end