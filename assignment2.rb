#!/usr/bin/ruby

#
# Generates a random-ish password
#   - must have four types of characters:
#     lower and upper case, number, and symbol
#   - allows for length of 8, 12, 16, 24, or 32 characters
# 

# Build arrays of valid character types
lower_case_chars = ('a'..'z').to_a
upper_case_chars = ('A'..'Z').to_a
numeric_chars = 0.upto(9).to_a
symbol_chars = ('!'..'/').to_a
default_length = 8

#menu / input length of password
puts "\nSecure Password Generator"
puts "Select password length:"
puts "8, 12, 16, 24, or 32 characters: "

desired_length = gets.chop.to_i # input length of password

#verify input is within range
if [8,12,16,24,32].count(desired_length) == 0 then #failure, default
    password_length = default_length #default value of 8 character password
    puts "Defaulting to 8-character password..."
else # success
    password_length = desired_length
    puts "Generating #{password_length}-character password..."
end

char_types = 4 #kinds of characters count
chars_per_type = password_length / char_types #number of each kind of character

#clear password
random_chars = []

#build random character arrays for each type of character
1.upto chars_per_type do 
    random_chars << lower_case_chars[rand(lower_case_chars.length)]
    random_chars << upper_case_chars[rand(upper_case_chars.length)]
    random_chars << numeric_chars[rand(numeric_chars.length)]
    random_chars << symbol_chars[rand(symbol_chars.length)]
end

#mix up the chosen chars in the array
random_chars = random_chars.shuffle
#format as a string and print to display
puts
puts random_chars.join
puts
