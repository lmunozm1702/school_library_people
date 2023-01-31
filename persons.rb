require 'securerandom'
require './nameable'
require './capitalize_decorator'
require './trimmer_decorator'
class Person < Nameable
  # creating accessors
  attr_accessor :name, :age
  attr_reader :id

  def initialize(name, age = 'unknown', parent_permission: true)
    super()
    @name = name
    @age = age
    @parent_permission = parent_permission
    @id = SecureRandom.uuid
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
end

person = Person.new('maximilianus', 22)
pp person.correct_name
capitalizedPerson = CapitalizeDecorator.new(person)
pp capitalizedPerson.correct_name
capitalizedTrimmedPerson = TrimmerDecorator.new(capitalizedPerson)
pp capitalizedTrimmedPerson.correct_name
