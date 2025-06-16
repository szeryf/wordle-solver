#!ruby -w

words = File.readlines("./words5.txt").map(&:chomp)

$scores = Hash.new(0)

words.each do |word|
  word.split(//).each { |letter| $scores[letter] = $scores[letter] + 1 }
end

p $scores.sort_by { |k, v| v }.reverse

def score(word)
  word.split(//).uniq.inject(0) { |sum, letter| sum + $scores[letter.downcase] }
end

words_streams = [words.dup, words.dup, words.dup, words.dup]

ARGV.each do |arg|
  raise arg unless arg =~ /^([a-z]{5})=(([byg]{5},?){1,4})$/

  letters = $1.split(//)
  streams = $2.split(",")

  words_streams =
    streams.map.with_index do |stream, i|
      words_stream = words_streams[i]

      results = stream.split(//)

      letters
        .zip(results)
        .each
        .with_index do |(letter, result), i|
          words_stream =
            case result
            when "g"
              words_stream.select { |word| word[i] == letter }
            when "b"
              words_stream.reject { |word| word.include?(letter) }
            when "y"
              words_stream.select do |word|
                word.include?(letter) && word[i] != letter
              end
            end
        end
      puts "#{i}: #{$1} => #{words_stream.size} matches #{"(#{words_stream.join(", ")})" if words_stream.size < 10}"
      words_stream
    end
end

word_scores = Hash.new(0)
words_streams.each do |words_stream|
  words_stream.each do |word|
    word_scores[word] += score(word).to_f / words_stream.size
  end
end

puts(
  word_scores
    .sort_by { |_, score| score }
    .reverse
    .take(10)
    .map { |word, score| "#{word} = #{score}" }
)
