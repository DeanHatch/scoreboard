# This is a holder of values which define a Navigation Link Item.
class NavItem < Object
	attr_accessor :href, :text, :css_class, :target
	
	def initialize(href, text,
			options={css_class: "nav", target: nil})
		self.href = href
		self.text = text
		self.css_class = options[:css_class] ||= "nav"
		self.target = options[:target] ||= nil
	end
		
end
