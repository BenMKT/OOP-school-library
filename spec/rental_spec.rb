require_relative '../rental'
require_relative '../book'
require_relative '../person'

describe Rental do
  context 'Given a provided rental' do
    book = Book.new('Wangrin', 'Amadou H. Bah')
    person = Person.new(51, 'Manuel Sanchez')
    rental = Rental.new('2023-12-10', book, person)

    it "returns the rental's correct date" do
      expect(rental.date).to eql('2023-12-10')
    end

    it 'returns the correct book' do
      expect(rental.book).to eql(book)
    end

    it 'returns the correct person' do
      expect(rental.person).to eql(person)
    end
  end
end
