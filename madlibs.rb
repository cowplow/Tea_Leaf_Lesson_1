def generate_word_list(type)
  words = File.open("#{type}", "r") do |r|
    r.read
  end.split
  words
end

nouns = generate_word_list("nouns.txt")
verbs = generate_word_list("verbs.txt")
adjectives = generate_word_list("adjectives.txt")

story = File.open("story.txt", "r") do |r|
  r.read
end

story.gsub!("NOUN").each do
  nouns.sample
end

story.gsub!("VERB").each do
  verbs.sample
end

story.gsub!("ADJECTIVE").each do
  adjectives.sample
end

puts story
