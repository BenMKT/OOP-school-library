require_relative '../trimmer_decorator'
require_relative '../person'

describe TrimmerDecorator do
  context 'Given a provided person' do
    person = Person.new(22, 'Maximilianus')
    trimmed_person = TrimmerDecorator.new(person)

    it "returns the person's name trimmed to 9 characters if longer" do
      expect(trimmed_person.correct_name.length).to eql(9)
    end
  end
end
