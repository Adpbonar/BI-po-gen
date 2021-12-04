require "administrate/base_dashboard"

class SavedServiceDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    saved_details: Field::HasMany,
    id: Field::Number,
    title: Field::String,
    description: Field::Text,
    cost: Field::String.with_options(searchable: false),
    type: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    expense_exempt_from_tax: Field::Boolean,
    taxable: Field::Boolean,
    expense_cost: Field::String.with_options(searchable: false),
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    saved_details
    id
    title
    description
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    saved_details
    id
    title
    description
    cost
    type
    created_at
    updated_at
    expense_exempt_from_tax
    taxable
    expense_cost
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    saved_details
    title
    description
    cost
    type
    expense_exempt_from_tax
    taxable
    expense_cost
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

  # Overwrite this method to customize how saved services are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(saved_service)
  #   "SavedService ##{saved_service.id}"
  # end
end
