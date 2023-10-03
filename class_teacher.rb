require_relative 'class_person'

class Teacher < Person
  attr_reader :specialization

  def initialize(age, specialization, name = 'Unknown', parent_permission: true)
    super(age, name: name, parent_permission: parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end

teacher = Teacher.new(32, 'Mathematics', 'Mr. Weru')

puts teacher.name
puts teacher.age
puts teacher.specialization
puts teacher.can_use_services?