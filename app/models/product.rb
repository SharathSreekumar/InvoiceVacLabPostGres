class Product < ActiveRecord::Base
	def self.search(search)
	 	if search
    		#find(:all, :conditions => ['customer_email LIKE ? OR customer_phone LIKE ? OR product LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%"])
    		select(:product).where("product_name LIKE ?", "%#{search}%")
  		end
  	end
end
