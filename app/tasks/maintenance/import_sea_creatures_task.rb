require "csv"
module Maintenance
  class ImportSeaCreaturesTask < MaintenanceTasks::Task
    DATA_FILE = Rails.root.join("db/data/sea_creatures.csv").freeze

    def collection
      read_csv
    end

    def process(row)
      importer ||= SeaCreatureImporter.new
      importer.import_row(row)
    end

    def count
      read_csv.count
    end

    private

    def read_csv
      CSV.new(File.read(DATA_FILE), headers: true)
    end
  end
end
