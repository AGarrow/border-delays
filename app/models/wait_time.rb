class WaitTime < ActiveRecord::Base
  attr_accessible :bound, :duration, :commercial, :wday, :hour, :crossing_id
  validates_presence_of :crossing_id
  after_create :assign_values, :update_averages
  belongs_to :crossing

  def assign_values
    Time.zone = self.crossing.time_zone
    self.wday = Time.zone.now.wday
    self.hour = Time.zone.now.hour
    self.save
  end

  def update_averages
    Average.update_or_create({
      :delay => self.duration,
      :hour => self.hour,
      :wday => self.wday,
      :bound => self.bound,
      :commercial => self.commercial,
      :crossing_id => self.crossing_id
      })
  end
end
