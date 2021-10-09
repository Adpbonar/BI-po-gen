class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.destroy_duplicates_by(*columns)
    groups = select(columns).group(columns).having(Arel.star.count.gt(1))
    groups.each do |duplicates|
      records = where(duplicates.attributes.symbolize_keys.slice(*columns))
      records.offset(1).destroy_all
    end
  end
end
