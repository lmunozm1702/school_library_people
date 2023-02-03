require 'io/console'
require './app'

class Menu
  def initialize
    @app = App.new(self)
    @options = [
      { id: 1, option: 'list_all_books', menu_item: 'List all books' },
      { id: 2, option: 'list_all_persons', menu_item: 'List all persons' },
      { id: 3, option: 'create_person', menu_item: 'Create person' },
      { id: 4, option: 'create_book', menu_item: 'Create book' },
      { id: 5, option: 'create_rental', menu_item: 'Create rental' },
      { id: 6, option: 'rentals_to_person', menu_item: 'List all rentals for a given person id' },
      { id: 7, option: 'exit_app', menu_item: 'Exit' }
    ]
  end

  def show_options
    $stdout.clear_screen
    puts 'Please choose an option by entering the number:'
    @options.each do |option|
      puts "[#{option[:id]}] - #{option[:menu_item]}"
    end
    user_input = $stdin.getch
    do_option(user_input)
  end

  def do_option(selected_option)
    selected = @options.find { |op| op[:id] == selected_option.to_i }
    if selected.nil?
      unavailable_option
      return
    end
    $stdout.clear_screen
    @app.send(selected[:option])
  end

  def unavailable_option
    $stdout.clear_screen
    puts '** Invalid option, please preass any key to try again... **'
    $stdin.getch
    show_options
  end

  def main
    show_options
  end

  def comeback
    puts "\n** Please preass any key to go back to main menu... **"
    $stdin.getch
    main
  end
end

main_menu = Menu.new
main_menu.main
