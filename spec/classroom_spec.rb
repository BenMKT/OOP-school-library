require_relative '../classroom'
require_relative '../student'

RSpec.describe Classroom do
  describe '#add_student' do
    it 'adds a student to the classroom and associates them' do
      classroom = Classroom.new('Math Class')
      student = Student.new(16, classroom, 'Alice')

      classroom.add_student(student)

      expect(classroom.students).to include(student)
      expect(student.classroom).to eq(classroom)
    end
  end
end
