require "administrate/base_dashboard"

class ServiceItemDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    statement: Field::BelongsTo,
    discounts: Field::HasMany,
    details: Field::HasMany,
    id: Field::Number,
    title: Field::String,
    description: Field::Text,
    cost: Field::String.with_options(searchable: false),
    taxable: Field::Boolean,
    type: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    expense_exempt_from_tax: Field::Boolean,
    expense_cost: Field::String.with_options(searchable: false),
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    statement
    discounts
    details
    id
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    statement
    discounts
    details
    id
    title
    description
    cost
    taxable
    type
    created_at
    updated_at
    expense_exempt_from_tax
    expense_cost
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    statement
    discounts
    details
    title
    description
    cost
    taxable
    type
    expense_exempt_from_tax
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

  # Overwrite this method to customize how service items are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(service_item)
  #   "ServiceItem ##{service_item.id}"
  # end
end
