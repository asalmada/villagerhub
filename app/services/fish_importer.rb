class FishImporter
  include CritterAvailabilityImporter
  include CritterAttributeNormalizer

  def initialize(logger = Rails.logger)
    @logger = logger
  end

  def import_row(row)
    attrs = normalize_row(row)

    fish = Fish.find_or_initialize_by(entry_id: attrs[:entry_id])
    fish.assign_attributes(attrs)

    fish.availabilities = build_availabilities_from_row(row, fish)

    if fish.save
      @logger.info "Imported #{fish.name}"
    else
      error_message = "Failed to import #{attrs[:name]}: #{fish.errors.full_messages.join(', ')}"
      @logger.error error_message
      raise RuntimeError, error_message
    end
  end

  private

  def normalize_row(row)
    normalize_base_attributes(row).merge(
      spawn_location: normalize_spawn_location(row["Where/How"]),
      shadow_size: normalize_shadow_size(row["Shadow"]),
      visual_width: normalize_visual_width(row["Vision"]),
      catch_difficulty: normalize_catch_difficulty(row["Catch Difficulty"])
    )
  end

  def normalize_spawn_location(raw)
    if raw.blank?
      raise RuntimeError, "Blank spawn location"
    end

    case raw.strip
    when "Pier" then :pier
    when "Pond" then :pond
    when "River" then :river
    when "River (clifftop)" then :river_clifftop
    when "River (mouth)" then :river_mouth
    when "Sea" then :sea
    when "Sea (rainy days)" then :sea_rainy_days

    else
      @logger.warn "Spawn location not mapped: #{raw}"
      raise RuntimeError, "Spawn location not mapped: #{raw}"
    end
  end

  def normalize_shadow_size(raw)
    if raw.blank?
      raise RuntimeError, "Blank shadow size"
    end

    case raw.strip
    when "X-Small" then :x_small
    when "Small" then :small
    when "Medium" then :medium
    when "Large" then :large
    when "X-Large" then :x_large
    when "X-Large w/Fin" then :x_large_with_fin
    when "XX-Large" then :xx_large
    when "Long" then :long

    else
      @logger.warn "Shadow size not mapped: #{raw}"
      raise RuntimeError, "Shadow size not mapped: #{raw}"
    end
  end

  def normalize_visual_width(raw)
    if raw.blank?
      raise RuntimeError, "Blank visual width"
    end

    case raw.strip
    when "Very Narrow" then :very_narrow
    when "Narrow" then :narrow
    when "Medium" then :medium
    when "Wide" then :wide
    when "Very Wide" then :very_wide

    else
      @logger.warn "Visual width not mapped: #{raw}"
      raise RuntimeError, "Visual width not mapped: #{raw}"
    end
  end

  def normalize_catch_difficulty(raw)
    if raw.blank?
      raise RuntimeError, "Blank catch difficulty"
    end

    case raw.strip
    when "Very Easy" then :very_easy
    when "Easy" then :easy
    when "Medium" then :medium
    when "Hard" then :hard
    when "Very Hard" then :very_hard

    else
      @logger.warn "Catch difficulty not mapped: #{raw}"
      raise RuntimeError, "Catch difficulty not mapped: #{raw}"
    end
  end
end
