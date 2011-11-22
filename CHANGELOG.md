## 1.1.1 (2011-11-21)

* support Rails 3.0.x

## 1.1.0 (2011-11-20)

* keep hankaku kana as is

## 1.0.9 (2011-11-20)

* handle special characters such as `髙` or `﨑` correctly (Body)

## 1.0.8 (2011-11-20)

* handle special characters such as `髙` or `﨑` correctly (Ruby 1.8.7)

## 1.0.7 (2011-11-20)

* handle special characters such as `髙` or `﨑` correctly

## 1.0.6 (2011-11-20)

* Bug fix: wrong logic in the b_value_encode method

## 1.0.5 (2011-11-20)

* try to handle special characters such as `髙` or `﨑`, without success

## 1.0.4 (2011-11-20)

* now, work with Ruby 1.9.x

## 1.0.3 (2011-11-20)

* handle fullwidth tildes and wave dashes correctly

## 1.0.2 (2011-11-19)

* convert `Sender`, `Reply-To`, `Resent-From`, `Resent-Sender`, `Resent-To`, `Resent-Cc` header values

## 1.0.1 (2011-11-19)

* convert `Cc` header value to iso-2022-jp encoding

## 1.0.0 (2011-11-19)

* fork from [ma2shita/mail_ja](https://github.com/ma2shita/mail_ja)
* convert `to` and `from` header values to iso-2022-jp encoding
* first public release as a gem