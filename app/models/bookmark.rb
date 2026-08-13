class Bookmark < ApplicationRecord
  belongs_to :movie
  belongs_to :list

  #   comment cannot be shorter than 6 characters (FAILED - 1)
  validates :comment, length: { minimum: 6 }
  validates :movie_id, uniqueness: { scope: :list_id }
end
