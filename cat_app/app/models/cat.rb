# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :datetime         not null
#  color       :string
#  name        :string           not null
#  sex         :string           not null
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Cat < ActiveRecord::Base
  include ActionView::Helpers::DateHelper
  validates :name, :birth_date, :sex, presence: true
  # validate :valid_color, :valid_sex

  has_many(:cat_rental_requests,
  :dependent => :destroy)

  def age
    time_ago_in_words(birth_date)
  end

  def birthday
    "#{birth_date.strftime("%B-%d-%Y")}"
  end

  private
  # def valid_color
  #   colors = ['red', 'green', 'blue']
  #    unless colors.include?(color)
  #     errors[:color] << "please choose from #{colors.join(', ')}"
  #    end
  # end

  # def valid_sex
  #   sexes = ['M', 'F']
  #   unless sexes.include?(sex)
  #     errors[:sex] << "please choose from #{sexes.join(', ')}"
  #   end
  # end
end
