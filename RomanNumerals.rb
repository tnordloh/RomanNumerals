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
    @error = ""
  end
  def is_arabic? number
    my_number = number.to_i 
    if my_number == 0 
      @error += "this isn't arabic.  roman?"
      return false
    end
    if  (1..3999).include?(my_number)
      error = ""
      return true
    end
    @error += "number not in range of 1 to 3999\n"
    return false
  end
  def roman_each_2 roman_numeral
    working_number = roman_numeral.dup
    reversed_map = @arabic_roman_map.invert
    while working_number.size > 0
      if working_number.size >= 2 && reversed_map[working_number[-2,2]]
        yield reversed_map[working_number[-2,2]]
        working_number.chop!.chop!
      elsif reversed_map[working_number[-1]]
        yield reversed_map[working_number[-1]]
        working_number.chop!
      end
    end
  end
  def roman_each roman_numeral
    working_number = roman_numeral.dup
    reversed_map = @arabic_roman_map.invert
    while working_number.size > 0
      if working_number.size >= 2 && reversed_map[working_number[-2,2]]
        yield reversed_map[working_number[-2,2]]
        working_number.chop!.chop!
      elsif reversed_map[working_number[-1]]
        yield reversed_map[working_number[-1]]
        working_number.chop!
      end
    end
  end
  def only_roman_digits? roman_number
    remainder= roman_number.dup 
    @arabic_roman_map.each_value {|value|
      remainder.delete!(value)
    }
    if remainder.size > 0 
      @error += "roman numeral #{roman_number} contains non-allowed values"
      return false 
    end
    return true
  end
  def roman_digits_in_order? roman_number
    map_reverse = @arabic_roman_map.invert
    last_value = 0
    roman_each(roman_number) {|numeral| 
      if last_value <= numeral
        last_value = numeral
      else
        @error += "small-value numeral precedes low-value number\n"
        return false 
      end
    }
    true
  end
  def all_roman_characters_less_than_three? character
    list = @arabic_roman_map.values.select {|n| n.size==1}
    list.each { |ch| 
      if character.include?(ch * 4) 
        @error += "there were four characters in a row\n"
        return false
      end
    }
    return true
  end
  def is_roman? numeral
    return false if numeral.is_a?(Fixnum) || 
                   ! only_roman_digits?(numeral) ||
                   ! roman_digits_in_order?(numeral) ||
                   ! all_roman_characters_less_than_three?(numeral) 
    @error= ""
    true
  end
  def to_roman arabic_number
    value = ""
    arabic_number = arabic_number.to_i
    return nil unless is_arabic? arabic_number
    while arabic_number > 0
      arabic_roman_map_cur = @arabic_roman_map.select {|k,v| k <= arabic_number}
      highest_value = arabic_roman_map_cur.keys.max
      value += arabic_roman_map_cur[highest_value].to_s 
      arabic_number -= highest_value
    end
    value
  end
  def to_arabic roman_number
    return nil unless is_roman? roman_number
    value = 0 
    roman_each(roman_number) {|numeral| value += numeral   } 
    return value
  end
  def convert value
    return to_arabic(value) if is_roman?(value)
    return  to_roman(value) if is_arabic?(value)
    @error
  end
end
