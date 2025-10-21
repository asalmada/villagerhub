require "csv"
module Maintenance
  class ImportFishTask < MaintenanceTasks::Task
    DATA_FILE = Rails.root.join("db/data/fish.csv").freeze

    def collection
      read_csv
    end

    def process(row)
      importer ||= FishImporter.new
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
