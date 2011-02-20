class Evolution < Struct.new(:index, :grade)
  include Comparable
  
  def <=>(other)
    self.grade <=> other.grade
  end

  def acceptable_grade?
    self.grade > 0.3
  end

end