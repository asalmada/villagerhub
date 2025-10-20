class InsectImporter
  def initialize(logger = Rails.logger)
    @logger = logger
  end

  def import_row(row)
    attrs = normalize_row(row)

    insect = Insect.find_or_initialize_by(entry_id: attrs[:entry_id])
    insect.assign_attributes(attrs)

    availabilities = build_availabilities_from_row(row, insect)
    availabilities.each { |a| insect.availabilities << a }

    if insect.save
      @logger.info "Imported #{insect.name}"
    else
      error_message = "Failed to import #{attrs[:name]}: #{insect.errors.full_messages.join(', ')}"
      @logger.error error_message
      raise RuntimeError, error_message
    end
  end

  private

  def normalize_row(row)
    {
      name: row["Name"],
      entry_id: row["Unique Entry ID"],
      sell_price: row["Sell"].to_i,
      furniture_size: normalize_furniture_size(row["Size"]),
      furniture_has_surface: row["Surface"] == "Yes",
      description: row["Description"],
      catch_phrase: row["Catch phrase"],
      catches_to_unlock: row["Total Catches to Unlock"].to_i,
      spawn_location: normalize_spawn_location(row["Where/How"]),
      spawn_weather: normalize_spawn_weather(row["Weather"])
    }
  end

  def normalize_availability(row)
  end

  def normalize_furniture_size(raw)
    if raw.blank?
      raise RuntimeError, "Blank furniture size"
    end

    case raw.strip
    when "1x1" then :one_by_one
    when "2x1" then :two_by_one
    when "2x2" then :two_by_two
    when "3x2" then :three_by_two
    else
      Rails.logger.warn "Furniture size not mapped: #{raw}"
      raise RuntimeError, "Furniture size not mapped: #{raw}"
    end
  end

  def normalize_spawn_location(raw)
    if raw.blank?
      raise RuntimeError, "Blank spawn location"
    end

    case raw.strip
    when "Disguised on shoreline" then :disguised_on_shoreline
    when "Disguised under trees" then :disguised_under_trees
    when "Flying" then :flying
    when "Flying near blue/purple/black flowers" then :flying_near_blue_purple_black_flowers
    when "Flying near flowers" then :flying_near_flowers
    when "Flying near light sources" then :flying_near_light_sources
    when "Flying near trash (boots, tires, cans, used fountain fireworks) or rotten turnips" then :flying_near_trash
    when "Flying near water" then :flying_near_water
    when "From hitting rocks" then :from_hitting_rocks
    when "On beach rocks" then :on_beach_rocks
    when "On flowers" then :on_flowers
    when "On hardwood/cedar trees" then :on_hardwood_cedar_trees
    when "On palm trees" then :on_palm_trees
    when "On rivers/ponds" then :on_rivers_ponds
    when "On rocks/bushes" then :on_rocks_bushes
    when "On rotten turnips or candy" then :on_rotten_tunips_candy
    when "On the ground" then :on_the_ground
    when "On tree stumps" then :on_tree_stumps
    when "On trees (any kind)" then :on_trees
    when "On villagers" then :on_villagers
    when "On white flowers" then :on_white_flowers
    when "Pushing snowballs" then :pushing_snowballs
    when "Shaking trees" then :shaking_trees
    when "Shaking trees (hardwood or cedar only)" then :shaking_trees_hardword_cedar
    when "Underground (dig where noise is loudest)" then :underground
    else
      Rails.logger.warn "Spawn location not mapped: #{raw}"
      raise RuntimeError, "Spawn location not mapped: #{raw}"
    end
  end

  def normalize_spawn_weather(raw)
    if raw.blank?
      raise RuntimeError, "Blank spawn weather"
    end

    case raw.strip
    when "Any except rain" then :any_expect_rain
    when "Any weather" then :any
    when "Rain only" then :rain_only
    else
      Rails.logger.warn "Furniture size not mapped: #{raw}"
      raise RuntimeError, "Furniture size not mapped: #{raw}"
    end
  end

  def build_availabilities_from_row(row, insect)
    def parse_hemisphere_month(header)
      month_map = {
        "Jan" => 1, "Feb" => 2, "Mar" => 3, "Apr" => 4, "May" => 5,
        "Jun" => 6, "Jul" => 7, "Aug" => 8, "Sep" => 9, "Oct" => 10,
        "Nov" => 11, "Dec" => 12
      }

      hemi, mon = header.split
      hemisphere = hemi == "NH" ? :northern : :southern
      month = month_map[mon]
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

    availabilities = []
    row.headers.each do |header|
      next unless header.match?(/\A(NH|SH) /)

      hemisphere, month = parse_hemisphere_month(header)
      time_ranges = parse_time_ranges(row[header])

      next if time_ranges.nil?

      time_ranges.each do |time_range|
        availability = CritterAvailability.find_or_initialize_by(
          critter: insect,
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
end
