class User < ActiveRecord::Base
	# attr_accessible :name, :email #define the attrs that can be accessed from the outside
		# the code commented above is no longer available in Rails 4, check out http://t.cn/RP8jkg1 for reference

	before_save { self.email = email.downcase } # before_save forces Rails to downcase the email attribute before saving the user to the database
	
	VALID_EMAIL_REGREX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :name,  presence: true,
					  length: { :maximum => 50 }
	validates :email, presence: true,
					  format: { :with => VALID_EMAIL_REGREX	},
					  uniqueness: {:case_sensitive => false }
end