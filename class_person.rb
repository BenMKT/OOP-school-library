require_relative 'class_nameable'

class Person < Nameable
  attr_accessor :name, :age

  def initialize(age, name, parent_permission: true)
    super()
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  def correct_name
    @name
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  private

  def of_age?
    @age >= 18
  end
end
