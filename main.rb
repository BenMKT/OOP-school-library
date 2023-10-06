require_relative 'app'

def main
  app = App.new
  app.run
end

main if __FILE__ == $PROGRAM_NAME
