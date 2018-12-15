class HolidaysCalculation

  attr_reader :member, :holidays

  def available_days
    return 0 if member.working_months < 3
    member.working_months - holidays.past_years_booked_days
  end

  # @param [Member] member
  # @param [HolidayCollection] holidays
  def initialize(member, holidays)
    @member = member
    @holidays = holidays
  end

end