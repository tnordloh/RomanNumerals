#!/usr/bin/env ruby

require_relative 'RomanNumerals'


rn =  RomanNumerals.new 
puts rn.convert(ARGV[0])
