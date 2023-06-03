class Category < ApplicationRecord
  has_and_belongs_to_many :members
  has_many :transactions, dependent: :destroy
  has_many :total_amounts, dependent: :destroy
  belongs_to :user

  validates :name, :icon, :members_ids, presence: true
  validates :kind, inclusion: { in: %w[income expense] }  
end