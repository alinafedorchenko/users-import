class User < ApplicationRecord
  validates :first_name, :last_name, :email, :date_of_birth, presence: true
  validates :first_name, length: { minimum: 2 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validate :validate_age

  private

  def validate_age
    if date_of_birth.present? && (date_of_birth > 18.years.ago || date_of_birth < 100.years.ago)
      errors.add(:date_of_birth, 'User should be over 18 years old and less 100 years old.')
    end
  end
end
