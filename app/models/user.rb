class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end

class User < ActiveRecord::Base
	has_many :articles
	before_save { self.email = email.downcase }
	validates :username, uniqueness: { case_sensitive: false }, presence: true, length: {minimum: 3, maxium: 50}
	validates :email, uniqueness: { case_sensitive: false }, presence: true, email: true

end