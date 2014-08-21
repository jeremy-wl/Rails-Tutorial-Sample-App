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

require 'spec_helper'

describe User do
	# it "should create a new instance given a valid attribute" do
	# 	User.create!(:name => "JW", :email =>"de@we.org")
	# end
	attr = {  :name => "Jeremy Wong", 
			  :email => "jwong_a085@yahoo.com",
			  :password => "foobar",	
   			  :password_confirmation => "foobar"  # should be same as the one above
	}

	before	{ @user = User.new(attr) }
 
	# This new example is just a sanity check, verifying that the subject (@user) is initially valid

	subject { @user }

	it { should respond_to(:name)  }
	it { should respond_to(:email) }
    it { should respond_to(:password_digest) }
    it { should respond_to(:password) }
    it { should respond_to(:password_confirmation) }
    it { should respond_to(:authenticate) }

	it { should be_valid }

	describe "should reject names that are blank" do
		before{ @user.name = "" } 
		#This uses a before block to set the user’s name to an invalid (blank) value and then checks that the resulting user object is not valid.
		it { should_not be_valid }
	end

	describe "should reject names that are too long" do
		before { @user.name = "a"*51 }	# These only test the codes
		it { should_not be_valid }
	end

	describe "when email format is invalid" do
		it "should reject invalid email addresses" do
			addresses = %w[user@foo,com user_at_foo.org example.user@foo .foo@bar_baz.com foo@bar+baz.COM]
			addresses.each do |invalid_address|
				@user.email = invalid_address
				expect(@user).not_to be_valid
			end
		end
	end

	describe "when email format is valid" do
		it "should accept valid email addresses" do
			addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
			addresses.each do |valid_address|
				@user.email = valid_address
				expect(@user).to be_valid
			end
		end
	end

	describe "when email is invalid" do
		it "should not have a duplicate email address" do
			User.create!(attr)	# creates the first instance with an email
			user_with_duplicate_email = User.new(attr) # instantiate another one with a duplicate email
			user_with_duplicate_email.should_not be_valid
		end

		it "should not reject email addresses identical up to case" do
			upcased_email = attr[:email].upcase
			User.create!(attr)
			user_with_duplicate_email = User.new(:name => attr[:name], :email => upcased_email)	# could be simplified, check back what's on the book and the sreencast
			user_with_duplicate_email.should_not be_valid
		end
	end

	describe "password validations" do
		it "should require a password" do
			User.new(attr.merge(:password => "", :password_confirmation => "")). # should be filled
				should_not be_valid	# note that there's a dot at the end of the line above
		end

		it "should require a matching password confirmation" do
			User.new(attr.merge(:password_confirmation => "mismatch!!")). # doesn't match the initialized "foobar"
			should_not be_valid
		end
	end
	
	describe "password length control" do

		before	{ @user.password = @user.password_confirmation = "a"*5 }
		it { should be_invalid }
		before	{ @user.password = @user.password_confirmation = "a"*41 }
		it { should be_invalid }
	end

	describe "return value of authenticate method" do

		before { @user.save }
		let(:found_user)	{ User.find_by_email(@user.email) }

	  describe "with valid password" do
	  	it { should eq found_user.authenticate(@user.password) }  # If the given password matches the user’s password, it should return the user; otherwise, it should return false.
	  end

	  describe "with invalid password" do
	    let(:user_for_invalid_password)	{ found_user.authenticate("invalid_password!!") }	# returns false
	    it { should_not eq user_for_invalid_password }
	    specify { expect(user_for_invalid_password).to be_false }
	  end
	end

	# describe "password encryption" do

	# 	before	{ @user = User.create!(attr) }

	# 	it "should have an encryped password attribute" do
	# 		@user.should respond_to(:encrypted_password)
	# 	end

	# 	it "should set the encryped password attribute" do
	# 		@user.encrypted_password.should_not be_blank
	# 	end		

	# 	it "should have a salt" do
	# 		@user.should respond_to(:salt)	# then do migration cuz we are adding a new collumn to the db
	# 	end

	# end

	# describe "has_password? method" do

	# 	before	{ @user = User.create!(attr) }

	# 	it "should exist" do
	# 		@user.should respond_to(:has_password?)
	# 	end

	# 	it "should return true if the passwords match" do
	# 		@user.has_password?(attr[:password]).should be_true
	# 	end

	# 	it "should return false if the passwords don't match" do
	# 		@user.has_password?("mismatch!!!").should_not be_true
	# 	end
	# end

	# describe "authenticate method" do

	# 	it "should exist" do
	# 		User.should respond_to(:authenticate)	# "User.authenticate" is a class method so that we don't we @user
	# 	end

	# 	it "should return nil on an email/password mismatch" do
	# 		User.authenticate(attr[:email], "wrong_password!!").should be_nil
	# 	end

	# 	it "should return nil for an email address with no user" do
	# 		User.authenticate("no_such_useremail@WTF.com",attr[:email]).should be_nil
	# 	end

	# 	it "should return the user on email/password match" do
	# 		User.authenticate(attr[:email], attr[:password]).should == @user # if they match, User.authenticate returns @user instance
	# 	end


	# end

end
