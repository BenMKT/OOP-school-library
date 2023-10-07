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

    if person_type == 1
      print 'Student age:  '
      age = gets.chomp.to_i
      print 'Student name:  '
      name = gets.chomp
      print 'has parent permission? [Y/N]'
      parent_permission = gets.chomp.downcase
      print 'Enter classroom:  '
      classroom_name = gets.chomp
      classroom = Classroom.new(classroom_name)
      person = Student.new(age, classroom, name, parent_permission: parent_permission)

    elsif person_type == 2
      print 'Teacher name:  '
      name = gets.chomp
      print 'Teacher age:  '
      age = gets.chomp.to_i
      print 'Teacher specialization:  '
      specialization = gets.chomp
      person = Teacher.new(age, specialization, name)

    else
      puts 'Invalid person type.'
      return
    end

    @people.push(person)
    puts "#{person.class.name} created successfully!"
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
end
