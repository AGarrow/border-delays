module ApplicationHelper
  WEEKDAYS = %w(Sunday Monday Tuesday Wednesday Thursday Friday Saturday)
  def weekday (int)
    WEEKDAYS[int]
  end

  def clockTime (int)
    if int == 0
      return "12 AM"
    elsif int < 12
      return "#{int} AM"
    elsif int == 12
      return "12 PM"
    elsif int > 12
      return "#{int%12} PM"
    end
  end

end
