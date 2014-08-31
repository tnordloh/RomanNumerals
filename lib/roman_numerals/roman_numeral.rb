#!/usr/bin/env ruby

class RomanNumerals
  def initialize 
    @arabic_roman_map = { 1 => "I",   4 => "IV",
                          5 => "V",   9 => "IX",
                          10 => "X",  40 => "XL",
                          50 => "L",  90 => "XC",
                          100 => "C", 400 => "CD",
                          500 => "D", 900 => "CM",
                          1000 => "M"
    }
    @roman_arabic_map = @arabic_roman_map.invert
  end
  def is_arabic? number
    return (1..3999).include?(number.to_i)
  end
  def roman_split roman_number
    returnme = []
    roman_each(roman_number) {|numeral| returnme  << numeral   } 
    returnme
  end
  def roman_each roman_numeral
    working_number = roman_numeral.dup
    while working_number.size > 0
      if working_number.size >= 2 && @roman_arabic_map[working_number[-2,2]]
        yield @roman_arabic_map[working_number.slice!(-2,2)]
      elsif @roman_arabic_map[working_number[-1]]
        yield @roman_arabic_map[working_number.slice!(-1)]
      end
    end
  end
  def only_roman_digits? roman_number
    remainder= roman_number.dup 
    @arabic_roman_map.each_value {|value| remainder.delete!(value) }
    !(remainder.size > 0 )
  end
  def roman_digits_in_order? roman_number
    last_value = 0
    roman_each(roman_number) {|numeral| 
      if last_value <= numeral
        last_value = numeral
      else
        return false 
      end
    }
    true
  end
  def all_roman_characters_less_than_three? character
#QUESTION:this line is doing like 8 things, but it's one line.
#Is that ok?
    (@arabic_roman_map.values.select {|n| n.size==1}).each { |ch| 
                       return false if character.include?(ch * 4) }
    true
  end
  def is_roman? numeral
#QUESTION:three lines physically,, but spread out for readability.  Is that ok?
    return false if numeral.is_a?(Fixnum) || 
      ! only_roman_digits?(numeral) ||
      ! roman_digits_in_order?(numeral) ||
      ! all_roman_characters_less_than_three?(numeral) 
    true
  end
  def to_roman arabic_number
    arabic_number = arabic_number.to_i
    return nil unless is_arabic? arabic_number
    to_roman_private arabic_number
  end
  def to_arabic roman_number
    return nil unless is_roman? roman_number
    roman_split(roman_number).inject(0) {|result,element|  result + element }
  end
  def convert value
    return to_arabic(value) if is_roman?(value)
    return to_roman(value) if is_arabic?(value)
    return "invalid entry"
  end
private
  def to_roman_private arabic_number
    value = ""
    while arabic_number > 0
      highest_value =  (@arabic_roman_map.select {|k,v| k <= arabic_number}).keys.max
      value += @arabic_roman_map[highest_value]
      arabic_number -= highest_value
    end
    return value
  end
end
