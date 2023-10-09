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

def main
  app = App.new
  app.run
end

main
