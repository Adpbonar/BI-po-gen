if Rails.env.production?
    Lockbox.master_key = ENV['MASTER_KEY']
else
    Lockbox.master_key = Rails.application.credentials.lockbox[:master_key]
end