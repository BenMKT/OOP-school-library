require_relative 'person'
require_relative 'book'
require_relative 'student'
require_relative 'classroom'
require_relative 'teacher'
require_relative 'rental'
require 'json'
class App
  def initialize
    @books = []
    @people = []
    @rentals = []
    load_data
  end

  def list_books
    @books.each_with_index do |book, index|
      puts "#{index + 1}. Title: #{book.title}, Author: #{book.author}"
    end
  end

  def list_people
    @people.each_with_index do |person, index|
      puts "#{index + 1}) [#{person.class.name}], Name: #{person.name}, Age: #{person.age}, ID: #{person.id}"
    end
  end

  def create_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
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
    puts 'Student created successfully!'
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
    puts 'Teacher created successfully!'
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
    puts 'Please press the index corresponding to the book that you want: '
    list_books
    book_index = gets.chomp.to_i - 1
    puts 'Please type your corresponding index:'
    list_people
    person_index = gets.chomp.to_i - 1
    print 'Enter rental date (YYYY-MM-DD): '
    date = gets.chomp
    person = @people[person_index]
    rental = person.add_rental(@books[book_index], date)
    @rentals.push(rental)
    puts 'The book has been rented successfully!'
  end

  def list_rentals_for_person
    print 'To view your rental records, type your ID: '
    person_id = gets.chomp.to_i
    person = @people.find { |p| p.id == person_id }
    if person.nil?
      puts 'Person not found'
      return
    end
    puts "Rentals for #{person.name} (id: #{person.id}):"
    person.rentals.each do |rental|
      puts "Date: #{rental.date}, Book: #{rental.book.title}"
    end
  end

def load_data
  begin
    book_data = JSON.parse(File.read('books.json'))
    book_data.each do |book|
      @books << Book.new(book['title'], book['author'])
    end
  rescue Errno::ENOENT
    puts 'Books file not found. Starting with empty books list.'
  end
  begin
    person_data = JSON.parse(File.read('people.json'))
    person_data.each do |person|
      if person['type'] == 'student'
        @people << Student.new(person['name'], person['age'], person['id'], person['classroom'])
      elsif person['type'] == 'teacher'
        @people << Teacher.new(person['name'], person['age'], person['id'], person['specialization'])
      end
    end
  rescue Errno::ENOENT
    puts 'People file not found. Starting with empty people list.'
  end
  begin
    rental_data = JSON.parse(File.read('rentals.json'))
    rental_data.each do |rental|
      book = @books.find { |b| b.title == rental['book_title'] }
      person = @people.find { |p| p.id == rental['person_id'] }
      if book && person
        Rental.new(book, person)
      else
        puts "Error: rental data is invalid. Skipping rental."
      end
    end
  rescue Errno::ENOENT
    puts 'Rentals file not found. Starting with empty rentals list.'
  end
end
end