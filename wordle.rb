#!ruby -w

words = File.readlines("./words-wordle.txt").map(&:chomp)

scores = Hash.new(0)
words.each do |word|
  word.split(//).each { |letter| scores[letter] = scores[letter] + 1 }
end

def score(word, scores) =
  word.split(//).uniq.inject(0) { |sum, letter| sum + scores[letter.downcase] }

ARGV.each do |arg|
  if arg =~ /^([a-z]{5})=([byg]{5})/
    letters = $1.split(//)
    results = $2.split(//)
    letters
      .zip(results)
      .each
      .with_index do |(letter, result), i|
        words =
          case result
          when "g"
            words.select { |word| word[i] == letter }
          when "b"
            words.reject { |word| word.include?(letter) }
          when "y"
            words.select { |word| word.include?(letter) && word[i] != letter }
          end
      end
    puts "#{$1} => #{words.size} matches"
  else
    arg
      .split(//)
      .each { |letter| words = words.select { |word| word.include?(letter) } }
    puts "#{arg} => #{words.size} matches"
  end
end

puts(
  "\n",
  words
    .map { |word| [word, score(word, scores)] }
    .sort_by(&:last)
    .reverse
    .take(10)
    .map { |word, score| "#{word} = #{score}" }
)
