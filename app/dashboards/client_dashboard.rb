require "administrate/base_dashboard"

class ClientDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    po_users: Field::HasMany,
    id: Field::Number,
    type: Field::String,
    revenue_share: Field::Boolean,
    tax_rate: Field::String.with_options(searchable: false),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    emailaddress_ciphertext: Field::Text,
    name_ciphertext: Field::Text,
    phone_ciphertext: Field::Text,
    address_ciphertext: Field::Text,
    emailaddress_bidx: Field::String,
    name_bidx: Field::String,
    phone_bidx: Field::String,
    address_bidx: Field::String,
    country_code: Field::String,
    title_ciphertext: Field::Text,
    city_ciphertext: Field::Text,
    state_ciphertext: Field::Text,
    zip_ciphertext: Field::Text,
    company_ciphertext: Field::Text,
    company_bidx: Field::String,
    city_bidx: Field::String,
    state_bidx: Field::String,
    zip_bidx: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    po_users
    id
    type
    revenue_share
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    po_users
    id
    type
    revenue_share
    tax_rate
    created_at
    updated_at
    emailaddress_ciphertext
    name_ciphertext
    phone_ciphertext
    address_ciphertext
    emailaddress_bidx
    name_bidx
    phone_bidx
    address_bidx
    country_code
    title_ciphertext
    city_ciphertext
    state_ciphertext
    zip_ciphertext
    company_ciphertext
    company_bidx
    city_bidx
    state_bidx
    zip_bidx
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    po_users
    type
    revenue_share
    tax_rate
    emailaddress_ciphertext
    name_ciphertext
    phone_ciphertext
    address_ciphertext
    emailaddress_bidx
    name_bidx
    phone_bidx
    address_bidx
    country_code
    title_ciphertext
    city_ciphertext
    state_ciphertext
    zip_ciphertext
    company_ciphertext
    company_bidx
    city_bidx
    state_bidx
    zip_bidx
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how clients are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(client)
  #   "Client ##{client.id}"
  # end
end
