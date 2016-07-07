class Article < ActiveRecord::Base
	validates :title, presence: true, length: {minimum: 3, maxium: 50}
	validates :description, presence: true, length: {minimum: 5, maxium: 400}

end