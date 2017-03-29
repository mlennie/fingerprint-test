class SearchResult < ApplicationRecord

  validates_presence_of :json
  validates_presence_of :term
end
