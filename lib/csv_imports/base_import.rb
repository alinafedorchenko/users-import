require 'csv'

module CsvImports
  class BaseImport
    attr_reader :importer, :csv
    HeadersError = Class.new(StandardError)

    def initialize(importer)
      @importer = importer
    end

    def validate_headers
      raise HeadersError unless (required_columns - csv.headers).empty?
    end

    def setup_importer
      @csv = CSV.parse(importer.file.read, headers: true)
      importer.update(started_at: Time.current, status: :started, total_count: csv.size)
    end

    def import_rows
      csv.each do |row|
        if import_row(row)
          importer.increment(:created_count)
        else
          importer.increment(:failed_count)
        end
      end
    end

    def import
      setup_importer
      validate_headers
      import_rows
      importer.finish_import
    rescue CSV::MalformedCSVError, HeadersError
      importer.failed!
    end

    def required_columns
      raise NotImplementedError
    end
  end
end
