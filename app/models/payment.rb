class Payment < ApplicationRecord
    belongs_to :statement

    CURRENCY = {
        'CAD': '$ CA',
        'USD': '$ US',
        'EUR': '&euro;',
        'LB': '&#163;',
    }
end
