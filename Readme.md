# Canary Notifier
A simple way to get your ruby errors into Canary.

## Usage

Add this to your Gemfile:

```ruby
gem 'canary_notifier' , '~> 0.0.11'
```

Do a `bundle install`.

Open up config/environments/development.rb and add this do the end of the configure block:

```ruby
config.middleware.use CanaryNotifier, :app_name => 'Your App Name'
```

Any errors you have should now show up to Canary.
