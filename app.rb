require 'io/console'
require './books'
require './students'
require './teachers'
require './rental'

class App
  def initialize(main_menu)
    @main_menu = main_menu
    @books = []
    @persons = []
    @rentals = []
  end

  def list_all_books
    puts 'No books found!' if @books.empty?

    @books.each { |book| puts "Book: #{book.title} - Author: #{book.author}" }
    @main_menu.comeback
  end

  def list_all_persons
    $stdout.clear_screen
    puts 'No persons found!' if @persons.empty?

    @persons.each do |person|
      puts "Id: #{person.id}\nName: #{person.correct_name}\nAge: #{person.age}\n" \
           "Type: #{person.class}\nPermission: #{person.parent_permission}\n\n"
    end
    @main_menu.comeback
  end

  def create_student
    print 'Name: '
    name = gets.chomp
    print 'Age: '
    age = gets.chomp
    print 'Has parent permission [Y/N]: '
    permission = gets.chomp
    print 'Classroom: '
    classroom = gets.chomp
    @persons.push(Student.new(name, age.to_i, permission, classroom))
  end

  def create_teacher
    print 'Name: '
    name = gets.chomp
    print 'Age: '
    age = gets.chomp
    print 'Specialization: '
    special = gets.chomp
    @persons.push(Teacher.new(name, age, special))
  end

  def create_person
    puts 'Do you want to create'
    puts '[1] Student'
    puts '[2] Teacher'
    user_input = $stdin.getch
    create_student if user_input == '1'
    create_teacher if user_input == '2'

    puts '** Person added! **'
    @main_menu.comeback
  end

  def create_book
    $stdout.clear_screen
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    @books.push(Book.new(title, author))
    puts '** Book added! **'
    @main_menu.comeback
  end

  def show_persons
    if @persons.empty?
      puts "\n** No persons to rent a book **"
      return false
    end
    puts 'Select the person who\'s renting the book'
    @persons.each_with_index do |person, index|
      puts "[#{index}] - #{person.class} - Name: #{person.correct_name}"
    end
    $stdin.getch.to_i
  end

  def create_rental
    if @books.empty?
      puts '** No books to be rented **'
      @main_menu.comeback
    end
    puts 'Select the Book to be rented:'
    @books.each_with_index { |book, index| puts "[#{index}] - Title: #{book.title} - Author: #{book.author}" }
    book_selected = $stdin.getch.to_i

    @main_menu.comeback unless (person_selected = show_persons)

    print "\nDate to return the book [MM/DD/YYYY]: "
    date_return = gets.chomp

    @rentals.push(Rental.new(date_return, @books[book_selected], @persons[person_selected]))
    puts '** Rental added **'
    @main_menu.comeback
  end

  def rentals_to_person
    return unless (person_selected = show_persons)

    person_id = @persons[person_selected].id
    puts "\nRentals for #{@persons[person_selected].correct_name}"
    @rentals.map do |rental|
      puts "#{rental.date} - Book: #{rental.book.title} by #{rental.book.author}" if person_selected == person_id
    end
    @main_menu.comeback
  end

  def exit_app
    exit(true)
  end
end
