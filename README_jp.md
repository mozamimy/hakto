Hakto Safe SDBM Wrapper
=======================

## イントロダクション

Hakto Safe SDBM Wrapper（以下Haktoと省略）は、RubyのSDBMライブラリの安全なラッパーライブラリである。SDBMクラスのほぼ全てのインスタンスメソッドと互換性がある。

SDBMライブラリを使うときにありがちな、以下の様な煩雑なコードをスッキリまとめることができる。

**before**

    class Klass
      def initialize(db_path)
        @db_path = db_path
      end
      
      def method1
        SDBM.open(@db_path) do |dbm|
          dbm["hoge"] = "HOGE"
        end
      end
      
      def method2
        SDBM.open(@db_path) do |dbm|
          dbm["hoge"]
        end
      end
      
      :
      
    end            

**after**

    class Klass
      def initialize(db_path)
        @sdb = Hakto::SafeSDBM.new(db_path)
      end
      
      def method1
        sdb["hoge"] = "HOGE"
      end
      
      def method2
        sdb["hoge"]
      end
      
      :
      
    end            

## 動作環境

以下の環境で開発およびテストをしている。

- Linux（openSUSE 12.2）・Mac OS X 10.8.2
- Ruby 1.9.3

## 構成

- **bin**
- **doc** :: rdocによるドキュメント
- **lib**
  - **hakto**
    - **safe_sdbm.rb** :: SafeSDBMクラス
- **LICENSE**
- **Rakefile** :: gemパッケージ生成用のRakefile
- **README.md**
- **README_jp.md**
- **test** :: ユニットテスト
  - **tb_safe_sdbm.rb** :: SafeSDBM用ユニットテスト

## インストール

hakto-x.y.z.gemファイル（x、y、zはバージョン番号）をダウンロードし、以下のコマンドを入力してインストールする。

`$ sudo gem install hakto-x.y.z.gem`

または、RubyGems.orgからgemコマンドを使ってインストールすることもできる。

`$ sudo gem install hakto`

gemを使わない場合は、Rubyのパスが通っている適当な場所にsafe_sdbm.rbを置く。

## サンプルコード

tb_safe_sdbm.rbがサンプルコードを兼ねている。

## APIドキュメント

[http://quellencode.org/hakto-doc/](http://quellencode.org/hakto-doc/ "")を参照

## 作者について

Moza USANE  
[http://blog.quellencode.org/](http://blog.quellencode.org/ "")  
mozamimy@quellencode.org