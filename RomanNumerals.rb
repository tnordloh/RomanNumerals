#!/usr/bin/env ruby

class RomanNumerals
  def initialize 
    @arabic_roman_map = { 1 =>    "I", 4 => "IV",
                        5 =>    "V", 9 => "IX",
                        10 =>   "X", 40 => "XL",
                        50 =>   "L", 90 => "XC",
                        100 =>  "C", 400 => "CD",
                        500 =>  "D", 900 => "CM",
                        1000 => "M"
                      }
  end
  def is_roman?
  end
  def to_roman arabic_number
    value = ""
    return nil if arabic_number > 3999
    return nil if arabic_number < 0
    while arabic_number > 0
      arabic_roman_map_cur = @arabic_roman_map.select {|k,v| k <= arabic_number}
      highest_value = arabic_roman_map_cur.keys.max
      #puts "largest value is #{highest_value}"
      value += arabic_roman_map_cur[highest_value].to_s 
      arabic_number -= highest_value
    end
    value
  end
  def to_arabic roman_number
    working_number = roman_number.dup
    value = 0
    reversed_map = @arabic_roman_map.invert
    arabic_each working_number {|numeral| value += reversed_map[numeral]   }
    while working_number.size > 0
      if working_number.size >= 2 && reversed_map[working_number[-2,2]]
        value += reversed_map[working_number[-2,2]]
        working_number.chop!.chop!
      elsif reversed_map[working_number[-1]]
        value += reversed_map[working_number[-1]]
        working_number.chop!
      end
    end
    return value
  end
end
