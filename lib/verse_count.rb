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

	def self.getBooksOfBible
		return @wholeBible.keys
	end

	def self.getNumberOfChapters(bookTitle)
		return @wholeBible[bookTitle].last.keys
	end

	def self.getVerseCountForChapter(bookTitle, chapNum)
		@wholeBible[bookTitle].each do |chapVerse|
			if chapVerse.keys.first.to_i == chapNum
				return chapVerse.values.first
			end
		end
	end

	def self.getTotalBookVerseCount
		@allChapters = Hash.new
		@wholeBible.each do |wb|
			@allChapters[wb[0]] = {}
			wb[1].each do |chapterVerseArray|
				@allChapters[wb[0]].merge!(chapterVerseArray.keys.first => chapterVerseArray.values.first)
			end
		end
		return @allChapters
	end

end

