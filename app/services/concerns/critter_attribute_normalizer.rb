require "open-uri"

module CritterAttributeNormalizer
  extend ActiveSupport::Concern

  private

  def normalize_base_attributes(row)
    attrs = {
      name: row["Name"],
      entry_id: row["Unique Entry ID"],
      sell_price: row["Sell"].to_i,
      furniture_size: normalize_furniture_size(row["Size"]),
      furniture_has_surface: row["Surface"] == "Yes",
      description: row["Description"],
      catch_phrase: row["Catch phrase"],
      catches_to_unlock: row["Total Catches to Unlock"].to_i
    }
    attach_images(attrs, row)
    attrs
  end

  def attach_images(attrs, row)
    attrs[:icon_image] = download_image(row["Icon Image"])
    attrs[:critterpedia_image] = download_image(row["Critterpedia Image"])
    attrs[:furniture_image] = download_image(row["Furniture Image"])
  end

  def download_image(url)
    uri = URI.parse(url)
    return unless uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)

    downloaded_image = uri.open
    {
      io: downloaded_image,
      filename: File.basename(uri.path),
      content_type: downloaded_image.content_type
    }
  rescue OpenURI::HTTPError, SocketError => e
    Rails.logger.error "Failed to download image from #{url}: #{e.message}"
    nil
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
end
