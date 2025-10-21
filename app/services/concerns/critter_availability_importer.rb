module CritterAvailabilityImporter
  extend ActiveSupport::Concern

  MONTH_MAP = {
    "Jan" => 1, "Feb" => 2, "Mar" => 3, "Apr" => 4, "May" => 5,
    "Jun" => 6, "Jul" => 7, "Aug" => 8, "Sep" => 9, "Oct" => 10,
    "Nov" => 11, "Dec" => 12
  }.freeze

  private

  def build_availabilities_from_row(row, critter)
    availabilities = []
    row.headers.each do |header|
      next unless header.match?(/\A(NH|SH) /)

      hemisphere, month = parse_hemisphere_month(header)
      time_ranges = parse_time_ranges(row[header])

      next if time_ranges.nil?

      time_ranges.each do |time_range|
        availability = CritterAvailability.find_or_initialize_by(
          critter: critter,
          hemisphere: hemisphere,
          month: month,
          start_minute: time_range[:start_minute],
          end_minute: time_range[:end_minute],
          all_day: time_range[:all_day]
        )
        availabilities << availability
      end
    end
    availabilities
  end

  def parse_hemisphere_month(header)
    hemi, mon = header.split
    hemisphere = hemi == "NH" ? :northern : :southern
    month = MONTH_MAP[mon]
    [ hemisphere, month ]
  end

  def parse_time_ranges(cell)
    if cell.blank?
      raise RuntimeError, "Blank time ranges"
    end

    return nil if cell.downcase == "na"
    return [ { start_minute: nil, end_minute: nil, all_day: true } ] if cell.downcase == "all day"

    cell.split(";").map do |range|
      start_str, end_str = range.split("–").map(&:strip)
      start_minute = time_string_to_minutes(start_str)
      end_minute   = time_string_to_minutes(end_str)
      { start_minute: start_minute, end_minute: end_minute, all_day: false }
    end
  end

  def time_string_to_minutes(time_str)
    hour, meridian = time_str.strip.match(/(\d+)\s*(AM|PM)/i).captures
    hour = hour.to_i
    hour += 12 if meridian.upcase == "PM" && hour != 12
    hour = 0 if meridian.upcase == "AM" && hour == 12
    hour * 60
  end
end
