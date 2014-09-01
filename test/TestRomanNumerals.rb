#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../roman_numerals'

class TestRomanNumerals < MiniTest::Test
  def setup
    @rn = RomanNumerals.new
    @list = []
    File.open('known_numerals').each { |line|
      line.chomp!
      num, val = line.split(' = ')
      @list[num.to_i] = val
   }
  end
  def test_convert_to_roman
    (1...(@list.size)).each {|i|
      assert_equal @list[i], @rn.convert(i) 
    }
  end
  def test_all_to_roman_possibilities
    (1...(@list.size)).each {|i|
      assert_equal @list[i], @rn.to_roman(i) 
    }
  end

  def test_convert_to_arabic
    (1...(@list.size)).each {|i|
      #added the to_s below to deal with a case I was missing when 
      #I tried to move String conversion out of the main to_arabic
      #code."
      assert_equal i, @rn.convert(@list[i].to_s) 
    }
  end
  def test_all_to_arabic_possibilities
    (1...(@list.size)).each {|i|
      assert_equal i, @rn.to_arabic(@list[i]) 
    }
  end

  def test_that_non_arabic_numbers_return_nil
    assert_equal false, @rn.to_arabic("hello") 
  end

  def test_that_non_roman_numbers_return_nil
    assert_equal false, @rn.to_roman("hello") 
  end

  def test_roman_less_than_three
    assert_equal false, @rn.all_roman_characters_less_than_three?("VVVIIII") 
    assert_equal true, @rn.all_roman_characters_less_than_three?("VVVIII") 
  end
  def test_is_roman?
    assert_equal true, @rn.is_roman?("VVVIII") 
    assert_equal false, @rn.is_roman?("1234") 
    assert_equal false, @rn.is_roman?(1234) 
    assert_equal false, @rn.is_roman?("XM") 
    assert_equal false, @rn.is_roman?("XXXX") 
  end
  def test_all_roman_digits_in_order?
    assert_equal false, @rn.roman_digits_in_order?("XIC") 
    assert_equal true, @rn.roman_digits_in_order?("IX") 
  end
  def test_all_roman_digits_in_order?
    assert_equal false, @rn.roman_digits_in_order?("XIC") 
    assert_equal true, @rn.roman_digits_in_order?("IX") 
  end
end
