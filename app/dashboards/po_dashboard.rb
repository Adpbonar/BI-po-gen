require "administrate/base_dashboard"

class PoDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    statements: Field::HasMany,
    user: Field::BelongsTo,
    installments: Field::HasMany,
    po_users: Field::HasMany,
    groups: Field::HasMany,
    id: Field::Number,
    title: Field::String,
    description: Field::Text,
    start_date: Field::DateTime,
    end_date: Field::DateTime,
    po_number: Field::Number,
    service_type: Field::String,
    number_of_installments: Field::Number,
    tax_amount: Field::String,
    issued_to_ciphertext: Field::String,
    company_name_ciphertext: Field::String,
    learning_coordinator_ciphertext: Field::String,
    found_ciphertext: Field::String,
    approved_by_ciphertext: Field::String,
    associate_percentage: Field::Number,
    founder_percentage: Field::Number,
    revenue_share: Field::Number.with_options(decimals: 2),
    status: Field::String,
    currency: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    company_name_bidx: Field::String,
    issued_to_bidx: Field::String,
    found_bidx: Field::String,
    slug: Field::String,
    show_participant: Field::Boolean,
    issue_code: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    statements
    user
    installments
    po_users
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    statements
    user
    installments
    po_users
    groups
    id
    title
    description
    start_date
    end_date
    po_number
    service_type
    number_of_installments
    tax_amount
    issued_to_ciphertext
    company_name_ciphertext
    learning_coordinator_ciphertext
    found_ciphertext
    approved_by_ciphertext
    associate_percentage
    founder_percentage
    revenue_share
    status
    currency
    created_at
    updated_at
    company_name_bidx
    issued_to_bidx
    found_bidx
    slug
    show_participant
    issue_code
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    statements
    user
    installments
    po_users
    groups
    title
    description
    start_date
    end_date
    po_number
    service_type
    number_of_installments
    tax_amount
    issued_to_ciphertext
    company_name_ciphertext
    learning_coordinator_ciphertext
    found_ciphertext
    approved_by_ciphertext
    associate_percentage
    founder_percentage
    revenue_share
    status
    currency
    company_name_bidx
    issued_to_bidx
    found_bidx
    slug
    show_participant
    issue_code
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

  # Overwrite this method to customize how pos are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(po)
  #   "Po ##{po.id}"
  # end
end
