class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.destroy_duplicates_by(*columns)
    groups = select(columns).group(columns).having(Arel.star.count.gt(1))
    groups.each do |duplicates|
      records = where(duplicates.attributes.symbolize_keys.slice(*columns))
      records.offset(1).destroy_all
    end
  end

  def colors
    colours = ["#115f9a", "#1984c5", "#22a7f0", "#48b5c4", "#76c68f", "#a6d75b", "#c9e52f", "#d0ee11", "#e60049", "#0bb4ff", "#50e991", "#e6d800", "#9b19f5", "#ffa300", "#dc0ab4", "#b3d4ff", "#00bfa0", "#b30000", "#7c1158", "#4421af", "#1a53ff", "#0d88e6", "#00b7c7", "#5ad45a", "#8be04e", "#ebdc78", "#fd7f6f", "#7eb0d5", "#b2e061", "#bd7ebe", "#ffb55a", "#ffee65", "#beb9db", "#fdcce5", "#8bd3c7"]
    return colours
  end

    # Type of currency being accepted form dropdowns
    CURRENCY = {
      'Canadian Dollar': 'CA $',
      'US Dollar': 'US $',
      'Euro': '&euro;',
      'British Pound': '&#163;',
    }
end
