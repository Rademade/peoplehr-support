require 'date'

class Member

  def id
    @data['EmployeeId']['DisplayValue']
  end

  def first_name
    @data['FirstName']['DisplayValue']
  end

  def last_name
    @data['LastName']['DisplayValue']
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def start_date
    @start_date ||= DateTime.parse(@data['StartDate']['DisplayValue'])
  end

  def working_months
    current_date = DateTime.now
    (current_date.year * 12 + current_date.month) - (start_date.year * 12 + start_date.month)
  end

  protected
  def initialize(data)
    @data = data
  end

end