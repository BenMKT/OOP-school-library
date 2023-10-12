require_relative 'person'
require_relative 'book'
require_relative 'student'
require_relative 'classroom'
require_relative 'teacher'
require_relative 'rental'
class App # rubocop:disable Metrics/ClassLength
  attr_reader :books, :people, :rentals

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
    puts 'Please press the number corresponding to the book that you want: '
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

  def save_data # rubocop:disable Metrics/MethodLength
    books_data = @books.map { |book| { title: book.title, author: book.author } }
    people_data = @people.map do |person|
      data = { name: person.name, age: person.age }
      if person.is_a?(Student)
        data[:type] = 'student'
        data[:classroom] = person.classroom.label
      elsif person.is_a?(Teacher)
        data[:type] = 'teacher'
        data[:specialization] = person.specialization
      end
      data
    end
    rentals_data = @rentals.map do |rental|
      {
        person_index: @people.index(rental.person),
        book_index: @books.index(rental.book),
        date: rental.date
      }
    end

    File.write('books.json', books_data.to_json)
    File.write('people.json', people_data.to_json)
    File.write('rentals.json', rentals_data.to_json)
  end

  def load_data
    load_books
    load_people
    load_rentals
  rescue Errno::ENOENT => e
    puts "Error loading data: #{e.message}"
  end

  def load_books
    return unless File.exist?('books.json')
    books_data = JSON.parse(File.read('books.json'))
    @books = books_data.map { |data| Book.new(data['title'], data['author']) }
  end

end
