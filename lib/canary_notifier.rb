require 'rest_client'

class CanaryNotifier
  def initialize(app, options = {})
    @app, @options = app, options
  end

  def call(env)
    @app.call(env)
  rescue Exception => e
    url = 'http://stark:abc123@bugdrop.canary.io/notify'
    first_line = e.backtrace.first
    (file_name, line_number, method) = first_line.split(':')
    data = {}
    data["app_name"] = @options[:app_name] || "No Name"
    data["bug_name"] = "#{e.class.name}: #{e.to_s}"
    data["bug_class"] = e.class.name
    data["file_name"] = file_name
    data["line_number"] = line_number.to_i
    data["bug_method"] = method.split.last
    data["language"] = 'ruby'
    data["backtrace"] = e.backtrace.join("\n")

    lines = File.readlines(file_name)
    start_line = line_number.to_i - 4
    start_line = 0 if start_line < 0
    end_line = line_number.to_i+2
    end_line = lines.size - 1 if end_line > lines.size - 1

    data["code_sample"] = lines[start_line..end_line].join

    data["code_sample_line_start"] = line_number.to_i - 3
    data["code_sample_line_start"] = 1 if data["code_sample_line_start"] < 1
    RestClient.post url,  data.to_json
 
    raise e
  end
end
