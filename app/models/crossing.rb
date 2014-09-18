require 'geography'
class Crossing < ActiveRecord::Base
  attr_accessible :location, :title, :time_zone, :province, :state
  validates_uniqueness_of :title
  has_many :wait_times
  has_many :averages
  before_create :assign_timezone
  validates_inclusion_of :state, in: Geography::STATES, allow_blank: false
  validates_inclusion_of :province, in: Geography::PROVINCES, allow_blank: false

  ZONES = {
    "ME" => "Eastern Time (US & Canada)",
    "MI" => "Eastern Time (US & Canada)",
    "MN" => "Central Time (US & Canada)",
    "MT" => "Mountain Time (US & Canada)",
    "ND" => "Central Time (US & Canada)",
    "NY" => "Eastern Time (US & Canada)",
    "VT" => "Eastern Time (US & Canada)",
    "WA" => "Pacific Time (US & Canada)",
  }





  def self.find_or_create(title, location)
    province = location.scan(/[A-Z]{2}/).first
    state = location.scan(/[A-Z]{2}/).second
    title = title == "St. Stephen 3rd Bridge" ? "St.Stephen 3rd Bridge" : title
    crossing = Crossing.where(:title => title, :location => location, :state => state, :province => province).first_or_create
  end

  def assign_timezone
    state = /[A-Z]{2}$/.match(self.location).to_s
    self.time_zone = ZONES[state]
  end

  def current_wait (bound, commercial)
    time = self.wait_times.where(:bound => bound, :commercial => commercial)
    if time.empty?
      return "N/A"
    else
      time = time.last.duration
      if time > 1 || time == 0
        return "#{time} minutes"
      elsif time == 1
        return "#{time} minute"
      end
    end
  end

  def chart_data(bound, commercial, wday)
    
    response = { 
      :labels => [],
      :average => [],
      :recent => []
    }
    
    #get data for average wait times
    average = self.averages.where(:bound => bound, :commercial => commercial, :wday => wday).sort_by{|av| av.hour}
    response[:labels] = average.map do |a|    
      x = a.hour % 12
      if x == 0 then
        x = 12
      end
      x
    end

    response[:average] = average.map do |a|  
      a.delay
    end
    
    #get data for today's wait times

    if Time.now.wday.to_i == wday.to_i
      day = Time.now - 2.days
      recent_times = self.wait_times.where(
        "created_at > ? AND wday = ? AND hour <= ? AND commercial = ? AND bound = ?", 
        day.to_date.beginning_of_day, 
        wday,
        self.wait_times.last.hour,
        commercial,
        bound
        )
    else
      day = Time.now - 8.days
      recent_times = self.wait_times.where(
        "created_at > ? AND wday = ? AND commercial = ? AND bound = ?", 
        day.to_date.beginning_of_day, 
        wday,
        commercial,
        bound
        )
    end
    response[:recent] = recent_times.map do |r|
      r.duration
    end
    response

  end

  def current_average(bound, commercial)
    average = self.averages.where(:bound => bound, :commercial => commercial)
    if average.empty?
      return "N/A"
    else
      return "#{average.last.delay} minutes"
    end
  end
end
