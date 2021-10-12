if environment == 'development'
    Lockbox.master_key = Rails.application.credentials.lockbox[:master_key]
end 