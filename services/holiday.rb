class Holiday

  def duration
    @data['DurationInDays']
  end

  def start_date
    @start_date ||= DateTime.parse(@data['StartDate'])
  end

  def end_date
    @end_date ||= DateTime.parse(@data['EndDate'])
  end

  def unique_key
    "#{@data['StartDate']}_#{@data['EndDate']}"
  end

  def this_year?
    start_date.year == DateTime.now.year
  end

  protected
  def initialize(data)
    @data = data
  end

end