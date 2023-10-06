require_relative 'person'

class Student < Person
  attr_reader :classroom

  def initialize(age, classroom, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end

  def classroom=(classroom)
    return if @classroom == classroom

    @classroom&.students&.delete(self)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end
end

student = Student.new(16, 'Physics', 'Danie')
