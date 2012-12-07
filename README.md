Hakto Safe SDBM Wrapper
=======================

## Introduction

Hakto Safe SDBM Wrapper is a safe wrapper of SDBM library. Hakto has compatibility of instance method's interface that is in SDBM class.

Hakto enables to tighten up a code that uses SDBM library like following codes.

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
        @sdb = SafeSDBM.new(db_path)
      end
      
      def method1
        sdb["hoge"] = "HOGE"
      end
      
      def method2
        sdb["hoge"]
      end
      
      :
      
    end            



## Operation Environment

We checked good operation within following environment.

- Linux（openSUSE 12.2）・Mac OS X 10.8.2
- Ruby 1.9.3

## Architectonics

- **bin**
- **doc** :: Rdoc documents.
- **lib**
  - **hakto**
    - **safe_sdbm.rb** :: Class of SafeSDBM
- **LICENSE**
- **Rakefile** :: Rakefile that is used to generate gem file
- **README.md**
- **README_jp.md**
- **test** :: Unit tests
  - **tb_safe_sdbm.rb** :: Unit test for SafeSDBM
  
## Install

Download hakto-x.y.z.gem, then execute following command to install Hakto.

`$ sudo gem install hakto-x.y.z.gem`

On the other hand, you can install from RubyGems.org to use following command.

`$ sudo gem install hakto`

Also you can install Hakto without gem. Allocate the safe_sdbm.rb where is ruby interpreter can load Hakto.

## Sample code

See tb_safe_sdbm.rb file. It is an unit test code, and it doubles with sample code.

## API document

See following website: [http://quellencode.org/hakto-doc/](http://quellencode.org/hakto-doc/ "")

## About Author

Moza USANE  
[http://blog.quellencode.org/](http://blog.quellencode.org/ "")  
mozamimy@quellencode.org