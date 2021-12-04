require "administrate/base_dashboard"

class AssociateStatementDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    po: Field::BelongsTo,
    line_items: Field::HasMany,
    payments: Field::HasMany,
    id: Field::Number,
    type: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    show_detailed: Field::Boolean,
    show_programs: Field::Boolean,
    company_name: Field::String,
    company_address: Field::Text,
    participant_name_ciphertext: Field::String,
    participant_address_ciphertext: Field::Text,
    total: Field::String.with_options(searchable: false),
    invoice_number: Field::String,
    status_code: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    po
    line_items
    payments
    id
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    po
    line_items
    payments
    id
    type
    created_at
    updated_at
    show_detailed
    show_programs
    company_name
    company_address
    participant_name_ciphertext
    participant_address_ciphertext
    total
    invoice_number
    status_code
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    po
    line_items
    payments
    type
    show_detailed
    show_programs
    company_name
    company_address
    participant_name_ciphertext
    participant_address_ciphertext
    total
    invoice_number
    status_code
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

  # Overwrite this method to customize how associate statements are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(associate_statement)
  #   "AssociateStatement ##{associate_statement.id}"
  # end
end
