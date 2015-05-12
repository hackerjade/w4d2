class Cat < ActiveRecord::Base
  include ActionView::Helpers::DateHelper

  validates :name, :birth_date, :sex, presence: true
  validate :valid_color, :valid_sex

  def age
    time_ago_in_words(birth_date)
  end

  private
  def valid_color
    colors = ['red', 'green', 'blue']
    unless colors.include?(color)
      errors[:color] << "please choose from #{colors.join(', ')}"
    end
  end

  def valid_sex
    sexes = ['M', 'F']
    unless sexes.include?(sex)
      errors[:sex] << "please choose from #{sexes.join(', ')}"
    end
  end
end
