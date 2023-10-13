require_relative '../capitalize_decorator'
require_relative '../person'

describe CapitalizeDecorator do
  context 'Given a provided person' do
    person = Person.new(22, 'maximilianus')
    capitalized_person = CapitalizeDecorator.new(person)

    it "returns the person's name first letter capitalized" do
      expect(capitalized_person.correct_name).to eql('Maximilianus')
    end
  end
end
