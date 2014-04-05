class Crossing < ActiveRecord::Base
  attr_accessible :location, :title, :time_zone
  validates_uniqueness_of :location, :title
  has_many :wait_times
  has_many :averages
  before_create :assign_timezone

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
    crossing = Crossing.where(:title => title, :location => location).first_or_create
  end

  def assign_timezone
    state = /[A-Z]{2}$/.match(self.location).to_s
    puts state
    self.time_zone = ZONES[state]
    puts self.time_zone
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
      a.hour
    end

    response[:average] = average.map do |a|  
      a.delay
    end
    
    #get data for today's wait times
    days_ago = Time.now.wday > wday.to_i ? Time.now - wday.to_i : 7 - (wday.to_i - Time.now.wday)
    day = Time.now - days_ago.days
    recent_times = self.wait_times.where(
      "created_at > ? AND wday = ? AND commercial = ? AND bound = ?", 
      day.to_date.beginning_of_day, 
      wday,
      commercial,
      bound
      )
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
