require './services/request'
require './services/member'
require './services/holiday'
require './services/holiday-collection'
require './services/holidays-calculation'


members = load_members
p "Member count – #{members.length}"

members.each_with_index do |member, index|

  # Initialize holidays models
  member_holidays_array = load_holidays(member.id)
  holidays_collection = HolidayCollection.new(member.id, member_holidays_array)

  # Calculation service
  days_count = HolidaysCalculation.new(member, holidays_collection).available_days

  # Update current member state
  update_holidays(member.id, days_count)

  # Output
  p "[#{index+1}/#{members.length}] #{member.full_name} updated to #{days_count}"
end
