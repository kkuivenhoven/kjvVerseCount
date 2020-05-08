require 'csv'
require 'open-uri'

class KjvVerseCount
	@wholeBible = Hash.new

	def initialize(name, chapter, verseTotal)
		@name = name
		@chapter = chapter
		@verseTotal = verseTotal
	end

	def self.init
		CSV.new(open("https://raw.githubusercontent.com/kkuivenhoven/kjvVerseCount/master/lib/kjvVerseCount.csv")

