require 'csv'
require 'open-uri'

class KjvVerseCount
	@wholeBible = Hash.new

=begin
	def initialize(name, chapter, verseTotal)
		@name = name
		@chapter = chapter
		@verseTotal = verseTotal
	end
=end

	def self.init
		puts "inside init"
		@wholeBible = Hash.new
		CSV.new(open("https://raw.githubusercontent.com/kkuivenhoven/kjvVerseCount/master/lib/kjvVerseCount.csv")).each do |bookChapterLine|
			if @wholeBible.has_key?(bookChapterLine[0])
				tmpHash = { bookChapterLine[1] => bookChapterLine[2] }
				@wholeBible[bookChapterLine[0]] << tmpHash
			else
				@wholeBible[bookChapterLine[0]] = Hash.new
				@wholeBible[bookChapterLine[0]] = []
				tmpHash = { bookChapterLine[1] => bookChapterLine[2] } 
				@wholeBible[bookChapterLine[0]] << tmpHash
			end
		end
	end

end

KjvVerseCount.new
KjvVerseCount.init
