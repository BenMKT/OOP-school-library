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
    @people.each_with_index do |person, index|
      puts "#{index + 1}. Name: #{person.name}, Age: #{person.age}"
    end
  end

  def create_person
    puts 'Enter person type (student/teacher):'
    person_type = gets.chomp.downcase

    puts 'Enter age:'
    age = gets.chomp.to_i

    if person_type == 'student'
      puts 'Enter classroom:'
      classroom_name = gets.chomp
      classroom = Classroom.new(classroom_name)
      person = Student.new(age, classroom)
    elsif person_type == 'teacher'
      puts 'Enter specialization:'
      specialization = gets.chomp
      person = Teacher.new(age, specialization)
    else
      puts 'Invalid person type.'
      return
    end

    @people.push(person)
    puts 'Person created!'
  end

  def create_book
    puts 'Enter title:'
    title = gets.chomp

    puts 'Enter author:'
    author = gets.chomp

    book = Book.new(title, author)
    @books.push(book)
    puts 'Book created!'
  end

  def create_rental
    puts 'Select a person by their index:'
    list_people
    person_index = gets.chomp.to_i - 1

    puts 'Select a book by its index:'
    list_books
    book_index = gets.chomp.to_i - 1

    puts 'Enter rental date (YYYY-MM-DD):'
    date = gets.chomp

    rental = @people[person_index].add_rental(@books[book_index], date)
    @rentals.push(rental)
    puts 'Rental created!'
  end

  def list_rentals_for_person
    puts 'Select a person by their index:'
    list_people
    person_index = gets.chomp.to_i - 1

    person = @people[person_index]
    puts "Rentals for #{person.name}:"
    person.rentals.each do |rental|
      puts "Date: #{rental.date}, Book: #{rental.book.title}"
    end
  end

  def display_options
    puts 'Options:'
    puts '1. List all books'
    puts '2. List all people'
    puts '3. Create a person'
    puts '4. Create a book'
    puts '5. Create a rental'
    puts '6. List rentals for a person'
    puts '7. Exit'
  end

  def process(choice)
    case choice
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
      return :quit
    else
      puts 'Invalid choice. Please select a valid option.'
    end
    :continue
  end

  def run
    loop do
      display_options
      print 'Select an option: '
      choice = gets.chomp.to_i

      result = process(choice)
      break if result == :quit
    end
  end
end

app = App.new
app.run
