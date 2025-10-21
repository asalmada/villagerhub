class SeaCreatureImporter
  include CritterAvailabilityImporter
  include CritterAttributeNormalizer

  def initialize(logger = Rails.logger)
    @logger = logger
  end

  def import_row(row)
    attrs = normalize_row(row)

    sea_creature = SeaCreature.find_or_initialize_by(entry_id: attrs[:entry_id])
    sea_creature.assign_attributes(attrs)

    sea_creature.availabilities = build_availabilities_from_row(row, sea_creature)

    if sea_creature.save
      @logger.info "Imported #{sea_creature.name}"
    else
      error_message = "Failed to import #{attrs[:name]}: #{sea_creature.errors.full_messages.join(', ')}"
      @logger.error error_message
      raise RuntimeError, error_message
    end
  end

  private

  def normalize_row(row)
    normalize_base_attributes(row).merge(
      movement_speed: normalize_movement_speed(row["Movement Speed"]),
    )
  end

  def normalize_movement_speed(raw)
    if raw.blank?
      raise RuntimeError, "Blank movement speed"
    end

    case raw.strip
    when "Stationary" then :stationary
    when "Very slow" then :very_slow
    when "Slow" then :slow
    when "Medium" then :medium
    when "Fast" then :fast
    when "Very fast" then :very_fast

    else
      @logger.warn "Movement speed not mapped: #{raw}"
      raise RuntimeError, "Movement speed not mapped: #{raw}"
    end
  end
end
