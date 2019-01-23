require 'csv'
class ExportsController < ApplicationController

  def index
  end

  def normal_csv
    respond_to do |format|
      format.csv do
        csv = generate_csv(User.column_names, User.all)
        send_data(csv)
      end
    end
  end

  def stream_csv
    respond_to do |format|
      format.csv do
        csv_enumerator = generate_streaming_csv(User.column_names, User.all)
        render_streaming_csv(csv_enumerator)
      end
    end
  end

  private

  def generate_csv(column_names, records)
    CSV.generate do |csv|
      csv << column_names # add headers to the CSV

      records.each do |record|
        csv << record.attributes.values_at(*column_names)
      end
    end
  end

  def generate_streaming_csv(column_names, records)
    Enumerator.new do |csv|
      csv << column_names.to_csv # add headers to the CSV

      records.each do |record|
        csv << record.attributes.values_at(*column_names).to_csv
      end
    end
  end

  def render_streaming_csv(csv_enumerator)
    # Delete this header so that Rack knows to stream the content.
    headers.delete("Content-Length")
    # Do not cache results from this action.
    headers["Cache-Control"] = "no-cache"
    # Let the browser know that this file is a CSV.
    headers['Content-Type'] = 'text/csv'
    # Do not buffer the result when using proxy servers.
    headers['X-Accel-Buffering'] = 'no'
    # Set the filename
    headers['Content-Disposition'] = "attachment; filename=\"report.csv\""
    # Set the response body as the enumerator
    self.response_body = csv_enumerator
  end
end
