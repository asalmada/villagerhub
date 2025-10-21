class InsectImporter
  include CritterAvailabilityImporter
  include CritterAttributeNormalizer

  def initialize(logger = Rails.logger)
    @logger = logger
  end

  def import_row(row)
    attrs = normalize_row(row)

    insect = Insect.find_or_initialize_by(entry_id: attrs[:entry_id])
    insect.assign_attributes(attrs)

    insect.availabilities = build_availabilities_from_row(row, insect)

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
    normalize_base_attributes(row).merge(
      spawn_location: normalize_spawn_location(row["Where/How"]),
      spawn_weather: normalize_spawn_weather(row["Weather"])
    )
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
      @logger.warn "Spawn location not mapped: #{raw}"
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
      @logger.warn "Spawn weather not mapped: #{raw}"
      raise RuntimeError, "Spawn weather not mapped: #{raw}"
    end
  end
end
