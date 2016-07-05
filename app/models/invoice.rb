class Invoice < ActiveRecord::Base
	def self.search(search)
	 	if search
    		#find(:all, :conditions => ['customer_email LIKE ? OR customer_phone LIKE ? OR product LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%"])
    		select(:invoice).uniq.where("customer_email LIKE ? OR customer_phone LIKE ? OR product LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
  		end
  	end
end
