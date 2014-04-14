namespace :geography do

  task :get_states_and_provinces => :environment do
    Crossing.all.each do | c |
      province, state = c.location.scan(/[A-Z]{2}/).flatten
      c.province = province
      c.state = state
      c.save
    end
  end

end