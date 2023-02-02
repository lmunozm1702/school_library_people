require './persons'

class Student < Person
  attr_reader :classroom

  def initialize(name, age, _classroom)
    super(name, age)
  end

  def play_hooky
    '¯(ツ)/¯'
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.student.push(self) unless classroom.students.include?(self)
  end
end
