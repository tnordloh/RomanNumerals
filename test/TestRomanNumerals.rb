#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../RomanNumerals'

class TestRomanNumerals < MiniTest::Unit::TestCase
  def setup
    @rn = RomanNumerals.new
  end

 def test_all_to_roman_possibilities
    list = []
    File.open('known_numerals').each { |line|
      line.chomp!
      num, val = line.split(' = ')
      list[num.to_i] = val
    }
    1.upto(list.size-1) {|i|
      assert_equal list[i], @rn.to_roman(i) 
    }
 end

 def test_all_to_arabic_possibilities
    list = []
    File.open('known_numerals').each { |line|
      line.chomp!
      num, val = line.split(' = ')
      list[num.to_i] = val
    }
    (1...(list.size)).each {|i|
      assert_equal i, @rn.to_arabic(list[i]) 
    }
 end

 def test_that_will_be_skipped
   skip "test this later"
 end
end