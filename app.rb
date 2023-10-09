require_relative 'person'
require_relative 'book'
require_relative 'student'
require_relative 'classroom'
require_relative 'teacher'
require_relative 'rental'
class App
  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def list_books
    @books.each_with_index do |book, index|
      puts "#{index + 1}. Title: #{book.title}, Author: #{book.author}"
    end
  end

  def list_people
    @people.each_with_index do |person, id|
      puts "[#{person.class.name}], Name: #{person.name}, Age: #{person.age}, ID: #{id + 1}"
    end
  end

  def create_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]:'
    person_type = gets.chomp.to_i

    case person_type
    when 1
      create_student
    when 2
      create_teacher
    else
      puts 'Invalid person type.'
    end
  end

  def create_student
      print 'Student age:  '
      age = gets.chomp.to_i
      print 'Student name:  '
      name = gets.chomp
      print 'has parent permission? [Y/N]'
      parent_permission = gets.chomp.downcase
      print 'Enter classroom:  '
      classroom_name = gets.chomp
      classroom = Classroom.new(classroom_name)
      student = Student.new(age, classroom, name, parent_permission: parent_permission)
      @people.push(student)
      puts "Student created successfully!"
  end

  def create_teacher
      print 'Teacher name:  '
      name = gets.chomp
      print 'Teacher age:  '
      age = gets.chomp.to_i
      print 'Teacher specialization:  '
      specialization = gets.chomp
      teacher = Teacher.new(age, specialization, name)
      @people.push(teacher)
      puts "Teacher created successfully!"
  end

  def create_book
    print 'Enter title:  '
    title = gets.chomp
    print 'Enter author:  '
    author = gets.chomp
    book = Book.new(title, author)
    @books.push(book)
    puts 'Book created successfully!'
  end

  def create_rental
    puts 'Please press the number corresponding to the book that you want:'
    list_books
    book_index = gets.chomp.to_i - 1
    puts 'Please type your ID:'
    list_people
    person_id = gets.chomp.to_i - 1
    print 'Enter rental date (YYYY-MM-DD):'
    date = gets.chomp
    rental = @people[person_id].add_rental(@books[book_index], date)
    @rentals.push(rental)
    puts 'The book has been rented successfully!'
  end

  def list_rentals_for_person
    puts 'To view your rental records, type your ID:'
    list_people
    person_id = gets.chomp.to_i - 1
    person = @people[person_id]
    puts "Rentals for #{person.name}:"
    person.rentals.each do |rental|
      puts "Date: #{rental.date}, Book: #{rental.book.title}"
    end
  end

  def run
    loop do
    display_options
    option = gets.chomp.to_i
    if option == 7
      puts 'Thank you for using the app. Goodbye!'
      break
    elsif option.between?(1, 6)
      case option
      when 1
        list_books
      when 2
        list_people
      when 3
        create_person
      when 4
        create_book
      when 5
        create_rental
      when 6
        list_rentals_for_person
      end
    else
      puts 'Error: Invalid number, try again'
    end
  end
  end
end
