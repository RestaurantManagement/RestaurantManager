module UsersHelper
	
	def gravatar_for(user, options = { size: 80, class: "" })
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		size = options[:size]
		className = options[:class] ? options[:class] : ""
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
		image_tag(gravatar_url, alt: user.name, class: "gravatar "+className)
	end

end
