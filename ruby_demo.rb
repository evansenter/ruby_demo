begin 
  puts "Enter a '.txt' file name"
  filename = gets.chomp
end until File.exists?(filename) && File.extname(filename) == ".txt"

output_filename = File.basename(filename, ".txt") + ".out.txt"

puts "Input File: #{filename}"
puts "Output File: #{output_filename}"

data = File.read(filename)

# Break the data into paragraphs, and remove any empty strings (can happen from a series of newlines)
parsed_data = data.split(/\n/).reject(&:empty?).map do |paragraph| 
  # Break the paragraphs into sentences (ended by ., !, ?) and trailing spaces on either side
  paragraph.scan(/.*?[\.\?!]/).map(&:strip).map do |sentence|
    # Break the sentence into words
    sentence.split(/\s+/)
  end
end

clean_data = parsed_data.map do |paragraph|
  # Paragraphs are preceded by 4 spaces
  (" " * 4) + paragraph.map do |sentence|
    # Sentences have one space between each word, and everything is lowercase except the first letter
    sentence.join(" ").downcase.capitalize
  # Sentences have two spaces between them 
  end.join("  ")
# Paragraphs are separated by a newline
end.join("\n")

File.open(output_filename, "w") { |file| file.write(clean_data) }