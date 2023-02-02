class Rental
  attr_accessor :date
  attr_reader :book

  def initialize(date, book)
    @date = date
    @book = book
    book.rentals.push(self)
  end
end