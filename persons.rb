require 'securerandom'
class Person
  # creating accessors
  attr_accessor :name, :age
  attr_reader :id

  def initialize(name, age = 'unknown', parent_permission: true)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @id = SecureRandom.uuid
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

a = Person.new('Benja')
pp a
pp a.id
