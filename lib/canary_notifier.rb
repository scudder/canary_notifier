require 'rest_client'

class CanaryNotifier
  def initialize(app, options = {})
    @app, @options = app, options
  end

  def call(env)
    @app.call(env)
  rescue Exception => e
    url = 'https://bugdrop-endpoint.herokuapp.com'

    data = {}
    data["app_key"] = @options[:app_key] 
    data["title"] = "#{e.class.name}: #{e.to_s}"

    data[:sections] = []

    backtrace = {}
    backtrace[:title] = 'Backtrace'
    backtrace[:type] = 'code'
    backtrace[:content] = e.backtrace.join("\n")

    environ = {}
    environ[:title] = 'Environment'
    environ[:type] = 'table'
    environ[:content] = env.to_a.map {|x| [x.first,x.last.to_s]}

    data[:sections] << environ
    data[:sections] << backtrace

    RestClient.post url,  data.to_json
 
    raise e
  end
end
