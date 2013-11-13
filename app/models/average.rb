class Average < ActiveRecord::Base
  attr_accessible :delay, :hour, :location, :title, :wday, :bound, :commercial, :crossing_id
  belongs_to :crossing
  def self.update_or_create(attributes)
    criteria = attributes.slice(:wday, :hour, :crossing_id, :bound, :commercial)
    average = Average.where(criteria)


    if not average.empty?
      average = average.first
      wait_times = WaitTime.where(criteria)
      sum = 0;
      wait_times.each do |wait_time|
        sum += wait_time.duration
      end
      # self.update_attributes(:delay => sum/wait_times.count)
      average.delay = sum/wait_times.count
      average.save
    else
      Average.create(attributes)
    end
  end
end
