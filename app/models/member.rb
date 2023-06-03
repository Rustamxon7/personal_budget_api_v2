class Member < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :categories
  has_many :transactions, dependent: :destroy
  has_many :total_amounts, dependent: :destroy

  validates :username, presence: true

  mount_uploader :image, ImageUploader

  def total_amount(category_id)
    return 0 if self.total_amounts.find_by(category_id: category_id).nil?
    self.total_amounts.find_by(category_id: category_id).amount
  end

  def total_balance
    self.total_amounts.where(kind: "income").sum(:amount) - self.total_amounts.where(kind: "expense").sum(:amount)
  end
end
