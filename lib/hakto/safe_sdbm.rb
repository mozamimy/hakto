#!/usr/bin/env ruby
# encoding: utf-8

require "sdbm"

# Hakto Safe SDBM Wrapper is a safe wrapper of SDBM class.
# Author::    Moza USANE (mailto:mozamimy@quellencode.org)
# Copyright:: Copyright (c) 2012 Moza USANE
# License::   MIT License (see the LICENSE file)
module Hakto

  # Wrapper of SDBM class.
  # It provides safe access to SDBM database.
  # You can use almost instance methods of SDBM class.
  class SafeSDBM

    attr_reader :db_path

    exclusion = [:close, :closed?]
    SDBM.instance_methods.each do |name|
      define_method(name) do |*args, &block|
        operate do |dbm|
          dbm.send(name, *args, &block)
        end
      end if !exclusion.index(name)
    end

    # Initialize SafeSDBM.
    # ==== Args
    # db_path :: A filepath of DB file
    def initialize(db_path)
      @db_path = db_path
    end

    # Print keys with following format.
    # key1, key2, key3, ...
    def print_keys
      print_flat("keys")
    end

    # Print key-value pair with following format.
    #
    # [key1]:value1
    #
    # [key2]:value2
    #
    # :
    #
    # :
    def print_each
      operate do |dbm|
        dbm.each_pair {|key, value| puts "[#{key}]:#{value}"}
      end
    end

    # Print values with following format.
    # value1, value2, value3, ...
    def print_values
      print_flat("values")
    end

    private
    def operate
      SDBM.open(@db_path) do |dbm|
        yield(dbm)
      end
    end

    def print_flat(var)
      operate do |dbm|
        dbm.send(var).each {|var| print "#{var}, "}
      end
    end
  end
end
