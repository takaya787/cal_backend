class Event < ApplicationRecord
  default_scope -> { order(date: :asc)}
  belongs_to :user

  validates(:title, presence: true,length: {maximum: 50 })
  validates(:year, presence: true,numericality: {
    only_integer: true, greater_than: 0,
  })

  validates(:month, presence: true,numericality: {
    only_integer: true, greater_than: 0,
    less_than: 13
  })
  validates(:date, presence: true,numericality: {
    only_integer: true, greater_than: 0,
    less_than: 32
  })
end
