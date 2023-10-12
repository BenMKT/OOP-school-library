require_relative '../book'
require_relative '../person'
require_relative '../rental'

describe Book do
  describe '#initialize' do
  it 'takes two parameters and returns a book object' do
    book = Book.new( 'Title', 'Author')
    expect(book).to be_an_instance_of(Book)
  end
  end

    describe '#add_rental' do

        it 'adds the rental to the rentals array' do
            book = Book.new('Title', 'Author')
            person = Person.new(21, 'John')
            rental = book.add_rental(person, 'Date')
            expect(book.rentals).to include(rental)
        end
    end
end