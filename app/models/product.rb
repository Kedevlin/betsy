class Product < ActiveRecord::Base
  belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :reviews
  has_and_belongs_to_many :categories

  validates :name, :price, :user_id, presence: true
  validates :name, uniqueness: true
  validates_numericality_of :price, :greater_than => 0
  validates_numericality_of :stock, :greater_than_or_equal_to => 0
  validates :photo_url, format: {with: /\.(png|jpg)\Z/i}, allow_nil: true

  def review_total
    return reviews.inject(0) { |sum, review| sum + review.rating }
  end

  def review_average
    if reviews.any?
      total = review_total
      return total * 1.0 / reviews.count
    else
      return 0
    end
  end

  def review_rounded
    return review_average.round
  end

end
