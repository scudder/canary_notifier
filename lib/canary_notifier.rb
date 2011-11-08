require 'json/pure'
require 'rest_client'

class CanaryNotifier
  def initialize(app, options = {})
    @app, @options = app, options
  end

  def call(env)
    @app.call(env)
  rescue Exception => e
    url = 'http://stark:abc123@bugdrop.bugdrop.io/notify'

    data = {}
    data["app"] = @options[:app_name] || "No Name"
    data["title"] = "#{e.class.name}: #{e.to_s}"

    data[:sections] = []

    backtrace = {}
    backtrace[:title] = 'Backtrace'
    backtrace[:body] = e.backtrace.join("\n")


    environ = {}
    environ[:title] = 'Environment'
    environ[:body] = env.to_a

    #data[:sections] << environ
    puts environ.to_a.to_json
    data[:sections] << backtrace

    RestClient.post url,  data.to_json
 
    raise e
  end
end
