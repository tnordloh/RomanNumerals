#!/usr/bin/env ruby

require_relative 'RomanNumerals'


rn =  RomanNumerals.new 
list = []
File.open('known_numerals').each { |line|
  line.chomp!
  num, val = line.split(' = ')
  list[num.to_i] = val
}
list.each_with_index {|val,i|
  my_conversion = rn.to_roman(i)
  puts "#{i}:#{val},#{my_conversion}" if not val.eql?(my_conversion)
}
