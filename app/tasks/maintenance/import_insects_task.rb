require "csv"
module Maintenance
  class ImportInsectsTask < MaintenanceTasks::Task
    def collection
      CSV.new(File.read(Rails.root.join("db/data/insects.csv")), headers: true)
    end

    def process(row)
      @importer ||= InsectImporter.new
      @importer.import_row(row)
    end

    def count
      CSV.read(Rails.root.join("db/data/insects.csv"), headers: true).count
    end
  end
end
