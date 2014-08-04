# library_spec.rb

require "spec_helper"

describe "Library Object"  do
	before :all do
		lib_arr = [
			Book.new("JavaScript the good part", "Douglas Crockford", :development),
			Book.new("Designing with web standards", "Jeffrey Zeldam", :design),
			Book.new("Dont make me think", "Steve Krug", :usability),
			Book.new("JavaScript Patterns", "Stoyan Stefanov", :development),
			Book.new("Responsive Web Design", "Ethan Marcotte", :design)
		]

		File.open "books.yml", "w" do |f|
			f.write YAML::dump lib_arr
		end
	end

	before :each do
		@lib = Library.new "books.yml"
	end

	describe "#new" do
		context "with no parameters" do
			it "should have no books" do
				lib = Library.new
				## lib.should have(0).books
				
				# can't use above code cause my rspec v is 3.0
				expect(lib).to have(0).books
				# this one is ok
				## lib.books.length.should == 0
			end
		end

		context "with a yaml file name parameter" do
			it "has five books" do
				## @lib.should have(5).books
				expect(@lib).to have(5).books
				## lib.books.length.should == 5
			end
		end
	end

	it "returns all the books in a given category" do
		## @lib.get_books_in_category(:development).length.should == 2
		# same as above example
		expect(@lib.get_books_in_category(:development)).to have(2).books
	end

	it "accepts new books" do
		@lib.add_book(Book.new "Design for the web", "Mark Boulton", :design)
		@lib.get_book("Design for the web").should be_an_instance_of Book
	end

	it "saves the library" do
		books = @lib.books.map { |book| book.title }
		@lib.save "our_new_library.yml"
		lib2 = Library.new "our_new_library.yml"
		books2 = lib2.books.map { |book| book.title }

		books.should == books2
	end

end