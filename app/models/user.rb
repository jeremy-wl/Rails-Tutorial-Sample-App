# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  password_digest :string(255)
#

class User < ActiveRecord::Base
	# attr_accessible :name, :email #define the attrs that can be accessed from the outside
		# the code commented above is no longer available in Rails 4, check out http://t.cn/RP8jkg1 for reference
	before_save { self.email = email.downcase } # before_save forces Rails to downcase the email attribute before saving the user to the database

	# attr_accessor :password # this only creates an attribute in memory, not in db (should never be in db), the one in the db should be an encrypted psw
	# attr_accessor :password_confirmation
	
	VALID_EMAIL_REGREX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :name,  		:presence => true,
					  		:length => { :maximum => 50 }
	validates :email,		:presence => true,
					 		:format => { :with => VALID_EMAIL_REGREX 	},
					 		:uniqueness => {:case_sensitive => false }
	validates :password,    :confirmation => true, # by making ":confirmation" in XX attribute true ,rails automatically creates an attribute XX_confirmation
							:length => { :within => 6..40 } # use :within to give it a range instead of using maximum and minimum attibutes
    has_secure_password

	# before_save	:encrypt_password

	# def has_password?(submitted_password)
	# 	encrypted_password == encrypt(submitted_password)
	# 	# call the method above for authentication; salt won't be changed, the password is only correct when ("encrypted_password == encrypt(submitted_password)") they match, the former one is in the db while the latter one is just submitted for encryption
	# end

	# def self.authenticate(email, submitted_password) # here, self refers to the user class itself
	# 	user = self.find_by_email(email)
	# 	return nil if user.nil? # there won't be such user if the email is not found
	# 	return nil if user.encrypted_password.nil?
	# 	return user if user.has_password?(submitted_password)
	# end

	# private
	# 		# salt won't be changed while encrypted_password could be
	# 	def encrypt_password
	# 		self.salt = make_salt if new_record? # no need to create a salt every time the psw gets changed
	# 		self.encrypted_password = encrypt(self.password)
	# 	end

	# 	def make_salt
	# 		secure_hash("#{Time.now.utc}--#{self.password}")
	# 	end

	# 	def encrypt(string)
	# 		secure_hash("#{salt}--#{string}")
	# 	end

	# 	def secure_hash(string)
	# 		Digest::SHA2.hexdigest(string)
	# 	end

end
