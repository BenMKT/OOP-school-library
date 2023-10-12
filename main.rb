require_relative 'app'

# This method prints the options the user can choose from and gets the user input
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

def main # rubocop:disable Metrics/MethodLength, Metrics/CyclomaticComplexity
  app = App.new
  loop do
    display_options
    option = gets.chomp.to_i
    if option == 7
      puts 'Saving data...'
      app.save_data
      puts 'Thank you for using the app. Goodbye!'
      break
    elsif option.between?(1, 6)
      case option
      when 1
        app.list_books
      when 2
        app.list_people
      when 3
        app.create_person
      when 4
        app.create_book
      when 5
        app.create_rental
      when 6
        app.list_rentals_for_person
      end
    else
      puts 'Error: Invalid number, try again'
    end
  end
end

main
