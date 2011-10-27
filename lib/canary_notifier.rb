class CanaryNotifier
  def initialize(app, options = {})
    @app, @options = app, options
  end

  def call(env)
    @app.call(env)
  rescue Exception => exception
    #Notifier.exception_notification(env, exception).deliver
    puts "CANARY!!!"    
    raise exception
  end
end
