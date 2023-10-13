require_relative '../teacher'

describe Teacher do
  context 'Given a provided teacher' do
    teacher = Teacher.new(41, 'Administration Organization', 'Manuel Sanchez')

    it "returns the teacher\'s correct age" do
      expect(teacher.age).to eql(41)
    end

    it "returns the teacher\'s correct specialization" do
      expect(teacher.specialization).to eql("Administration Organization")
    end

    it "returns the teacher\'s correct name" do
      expect(teacher.name).to eql("Manuel Sanchez")
    end
    
    it 'can define if the teacher can use the library service or not' do
      expect(teacher.can_use_services?).to eql(true)
    end
  end
end
