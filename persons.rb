class Person
  # creating accessors
  attr_accessor :name, :age, :id

  def initialize(name, age = 'unknown', parent_permission = true)
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  def is_of_age?
    return true if @age >= 18

    false
  end

  private :is_of_age?

  def can_use_services?
    return true if is_of_age? || @parent_permission

    false
  end
end
