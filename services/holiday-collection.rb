class HolidayCollection

  def past_years_booked_days
    days = 0
    @holidays.each do |holiday|
      days += holiday.duration unless holiday.this_year?
    end
    days
  end

  protected
  # @param employee_id
  # @param [Holiday[]] holidays
  def initialize(employee_id, holidays)
    @id = employee_id
    @holidays = filter_duplicates(holidays)
  end

  private
  # TODO Optimize
  def filter_duplicates(holidays)
    clear_holidays = {}
    holidays.each do |holiday|
      clear_holidays[holiday.unique_key] = holiday
    end
    clear_holidays.values
  end

end