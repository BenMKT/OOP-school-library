require_relative '../student'
require_relative '../classroom'

describe Student do
  describe '#play_hooky' do
    it 'returns a play hooky message' do
      student = Student.new(16, Classroom.new('Sample Classroom'), 'Alice')
      expect(student.play_hooky).to eq('¯\\(ツ)/¯')
    end
  end
end
