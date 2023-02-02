require 'securerandom'
require './nameable'
require './capitalize_decorator'
require './trimmer_decorator'
class Person < Nameable
  # creating accessors
  attr_accessor :name, :age, :rentals
  attr_reader :id

  def initialize(name, age = 'unknown', parent_permission: true)
    super()
    @name = name
    @age = age
    @parent_permission = parent_permission
    @id = SecureRandom.uuid
    @rentals = []
  end

  def correct_name
    @name
  end

  def of_age?
    return true if @age >= 18

    false
  end

  private :of_age?

  def can_use_services?
    return true if is_of_age? || @parent_permission

    false
  end

  def add_rental
    @rentals.push(rental)
    rental.person = self
  end
end
