class User < ActiveRecord::Base
	# attr_accessible :name, :email #define the attrs that can be accessed from the outside
		# the code commented above is no longer available in Rails 4, check out http://t.cn/RP8jkg1 for reference

	before_save { self.email = email.downcase } # before_save forces Rails to downcase the email attribute before saving the user to the database

	attr_accessor :password # this only creates an attribute in memory, not in db, the one in the db should be and encrypted psw
	# attr_accessor :password_confirmation
	
	VALID_EMAIL_REGREX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :name,  		:presence => true,
					  		:length => { :maximum => 50 }
	validates :email,		:presence => true,
					 		:format => { :with => VALID_EMAIL_REGREX	},
					 		:uniqueness => {:case_sensitive => false }
	validates :password,    :presence => true,
							:confirmation => true, # by making ":confirmation" in XX attribute true ,rails automatically creates an attribute XX_confirmation
							:length => { :within => 6..40 } # use :within to give it a range instead of using maximum and minimum attibutes
end