class Trip <ActiveRecord::Base
  belongs_to :station

  validates_presence_of :duration,
                        :start_date,
                        :start_station,
                        :end_date,
                        :end_station,
                        :bike_id,
                        :subscription_type

  def self.most_popular_day
    date = Trip.group(:start_date).order('count(*) DESC').pluck(:start_date).first
    Trip.most_popular_trip_date_count(date)
  end

  def self.most_popular_trip_date_count(date)
    count = Trip.group(:start_date).order('count(*) DESC').count[date]
    "#{date} with #{count} trips."
  end

  def start_station_latitude
    Station.find(start_station_id).latitude
  end

  def start_station_longitude
    Station.find(start_station_id).longitude
  end

  def end_station_latitude
    Station.find(end_station_id).latitude
  end

  def end_station_longitude
    Station.find(end_station_id).longitude
  end

  scope :longest_ride, -> {maximum(:duration)}
  scope :shortest_ride, -> {minimum(:duration)}
  scope :average_ride_length, -> {average(:duration).to_f.round(2)}
  scope :most_popular_starting_station, -> {maximum(:start_station)}
  scope :most_popular_ending_station, -> {maximum(:end_station)}
  # scope :most_popular_trip_date, -> {group(:start_date).order('count(*) DESC').limit(1).pluck(:start_date)}
  # scope :most_popular_trip_date_count, -> {group(:start_date).order('count(*) DESC').limit(1) }

end
