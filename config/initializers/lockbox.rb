unless Rails.env.production?
    Lockbox.master_key = ENV['GA_MEASUREMENT_ID']
else
    Lockbox.master_key = Rails.application.credentials.lockbox[:master_key]
end