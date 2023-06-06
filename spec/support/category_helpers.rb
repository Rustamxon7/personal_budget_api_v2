require 'faker'

module CategoryHelpers
  def category_info
    @category_info ||= {
      name: Faker::Lorem.word,
    }
  end

  def build_category
    FactoryBot.build(:category, name: category_info[:name], user_id: category_info[:user_id])
  end

  def create_category(user)
    FactoryBot.create(:category, name: category_info[:name], user_id: user.id)
  end
end
