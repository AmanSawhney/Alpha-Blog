require 'digest/md5'

module ApplicationHelper
	def gravatar_for(user, options = {size: 80}) 
		hash = Digest::MD5.hexdigest(user.email.downcase)
		size = options[:size]
		image_src = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
		image_tag(image_src, alt: user.username, class: "img-circle")
	end
end
