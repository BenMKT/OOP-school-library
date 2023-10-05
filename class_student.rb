require_relative 'class_person'

class Student < Person
  attr_reader :classroom

  def initialize(age, classroom, name = 'Unknown', parent_permission: true)
    super(age, name: name, parent_permission: parent_permission)
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

puts student.name
puts student.age
puts student.classroom
puts student.can_use_services?
puts student.play_hooky
