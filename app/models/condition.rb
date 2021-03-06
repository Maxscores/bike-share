class Condition < ActiveRecord::Base
  has_many :trips

  def self.temperature_ranges
    max = maximum(:max_temperature_f)
    min = minimum(:max_temperature_f)
    interval = 10
    build_range_array(max, min, interval)
  end

  def self.rides_on_days_in_temp_range_order_desc(lower, upper)
    where("conditions.max_temperature_f > #{lower} AND conditions.max_temperature_f <= #{upper}")
    .joins(:trips)
    .group(:date)
    .order("count_all DESC")
    .count
    .values
  end

  def self.wind_speed_ranges
    max = maximum(:mean_wind_speed_mph)
    min = minimum(:mean_wind_speed_mph)
    interval = 4
    build_range_array(max, min, interval)
  end

  def self.rides_on_days_in_wind_speed_range_order_desc(lower, upper)
    where("conditions.mean_wind_speed_mph > #{lower} AND conditions.mean_wind_speed_mph <= #{upper}")
    .joins(:trips)
    .group(:date)
    .order("count_all DESC")
    .count
    .values
  end

  def self.visibility_ranges
    max = maximum(:mean_visibility_miles)
    min = minimum(:mean_visibility_miles)
    interval = 4
    build_range_array(max, min, interval)
  end

  def self.rides_on_days_in_visibility_range_order_desc(lower, upper)
    where("conditions.mean_visibility_miles > #{lower} AND conditions.mean_visibility_miles <= #{upper}")
    .joins(:trips)
    .group(:date)
    .order("count_all DESC")
    .count
    .values
  end

  def self.precipitation_ranges
    max = maximum(:precipitation_inches)
    min = minimum(:precipitation_inches)
    interval = 0.5
    build_range_array(max, min, interval)
  end

  def self.rides_on_days_in_precipitation_range_order_desc(lower, upper)
    where("conditions.precipitation_inches >= #{lower} AND conditions.precipitation_inches <= #{upper}")
    .joins(:trips)
    .group(:date)
    .order("count_all DESC")
    .count
    .values
  end

  def self.average(trips_in_range)
    return 0 if trips_in_range.empty?
    trips_in_range.sum / trips_in_range.count
  end

  def self.max(trips_in_range)
    return 0 if trips_in_range.empty?
    trips_in_range.first
  end

  def self.min(trips_in_range)
    return 0 if trips_in_range.empty?
    trips_in_range.last
  end

  def self.number_of_groups(max, min, interval)
    ((max-min)/interval).ceil
  end


  def self.build_range_array(max, min, interval)
    (0...number_of_groups(max, min, interval)).map do |number|
      [(min + number * interval).round(1), (min + (number + 1) * interval).round(1)]
    end
  end

  def self.ride_by_temp
    temperature_ranges.reduce({}) do |result, (lower, upper)|
      rides_in_range = rides_on_days_in_temp_range_order_desc(lower, upper)
      result[:graph] = [] if result[:graph].nil?
      result[:table] = [] if result[:table].nil?
      result[:graph] << ["#{lower.to_i} - #{upper.to_i}", Condition.average(rides_in_range)]
      result[:table] << ["#{lower.to_i} - #{upper.to_i}", rides_in_range.count, Condition.min(rides_in_range), Condition.average(rides_in_range), Condition.max(rides_in_range)]
      result
    end
  end

  def self.ride_by_wind
    wind_speed_ranges.reduce({}) do |result, (lower, upper)|
      rides_in_range = rides_on_days_in_wind_speed_range_order_desc(lower, upper)
      result[:graph] = [] if result[:graph].nil?
      result[:table] = [] if result[:table].nil?
      result[:graph] << ["#{lower.to_i} - #{upper.to_i}", Condition.average(rides_in_range)]
      result[:table] << ["#{lower.to_i} - #{upper.to_i}", rides_in_range.count, Condition.min(rides_in_range), Condition.average(rides_in_range), Condition.max(rides_in_range)]
      result
    end
  end

  def self.ride_by_vis
    visibility_ranges.reduce({}) do |result, (lower, upper)|
      rides_in_range = rides_on_days_in_visibility_range_order_desc(lower, upper)
      result[:graph] = [] if result[:graph].nil?
      result[:table] = [] if result[:table].nil?
      result[:graph] << ["#{lower.to_i} - #{upper.to_i}", Condition.average(rides_in_range)]
      result[:table] << ["#{lower.to_i} - #{upper.to_i}", rides_in_range.count, Condition.min(rides_in_range), Condition.average(rides_in_range), Condition.max(rides_in_range)]
      result
    end
  end

  def self.ride_by_precip
    precipitation_ranges.reduce({}) do |result, (lower, upper)|
      rides_in_range = rides_on_days_in_precipitation_range_order_desc(lower, upper)
      result[:graph] = [] if result[:graph].nil?
      result[:table] = [] if result[:table].nil?
      result[:graph] << ["#{lower} - #{upper}", Condition.average(rides_in_range)]
      result[:table] << ["#{lower} - #{upper}", rides_in_range.count, Condition.min(rides_in_range), Condition.average(rides_in_range), Condition.max(rides_in_range)]
      result
    end
  end

end
