#!/usr/bin/ruby
# encoding: utf-8

require "test/unit"
require "stringio"
require_relative "../lib/hakto/safe_sdbm"

include Hakto

class SafeSDBMTest < Test::Unit::TestCase

  def capture_stdout(&block)
    original_stdout = $stdout
    $stdout = fake = StringIO.new
    begin
      yield
    ensure
      $stdout = original_stdout
    end
   fake.string
  end

  def setup
    @safe_sdbm = SafeSDBM.new("test.sdb")
    @safe_sdbm["hage"] = "HAGE"
    @safe_sdbm["fuga"] = "FUGA"
    @safe_sdbm["siga"] = "SIGA"
  end

  def test_not_have_close_method
    assert(!SafeSDBM.instance_methods.index(:close))
    assert(!SafeSDBM.instance_methods.index(:closed?))
  end

  def test_add_get
    assert_equal("HAGE", @safe_sdbm["hage"])
    assert_equal("FUGA", @safe_sdbm["fuga"])
    assert_equal("SIGA", @safe_sdbm["siga"])
  end

  def test_clear
    @safe_sdbm.clear
    assert_equal([], @safe_sdbm.keys)
  end

  def test_delete
    @safe_sdbm.delete("fuga")
    assert_equal(["hage", "siga"], @safe_sdbm.keys)
  end

  def test_keys
    assert_equal(["hage", "fuga", "siga"], @safe_sdbm.keys)
  end

  def test_each
    result = ""
    @safe_sdbm.each
    @safe_sdbm.each do |key, value|
      result += "#{key}:#{value},"
    end
    assert_equal("hage:HAGE,fuga:FUGA,siga:SIGA,", result)
  end

  def test_print_keys
    result = capture_stdout do
      @safe_sdbm.print_keys
    end
    assert_equal("hage, fuga, siga, ", result)
  end

  def test_print_each
    result = capture_stdout do
      @safe_sdbm.print_each
    end
    assert_equal("[hage]:HAGE\n[fuga]:FUGA\n[siga]:SIGA\n", result)
  end

  def test_print_values
    result = capture_stdout do
      @safe_sdbm.print_values
    end
    assert_equal("HAGE, FUGA, SIGA, ", result)
  end

  def test_db_path
    assert_equal("test.sdb", @safe_sdbm.db_path)
  end

  def test_length
    assert_equal(3, @safe_sdbm.length)
    assert_equal(3, @safe_sdbm.size)
  end

end
