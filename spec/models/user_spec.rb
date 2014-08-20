require 'spec_helper'

describe User do
	# it "should create a new instance given a valid attribute" do
	# 	User.create!(:name => "JW", :email =>"de@we.org")
	# end
	attr = { :name => "JW", :email => "JW@lin.com" }
	before	{ @user = User.new(attr) }

	# This new example is just a sanity check, verifying that the subject (@user) is initially valid

	subject { @user }

	it { should respond_to(:name)  }
	it { should respond_to(:email) }

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

	describe "when email format is invalid"
		it "should reject invalid email addresses" do
			addresses = %w[user@foo,com user_at_foo.org example.user@foo .foo@bar_baz.com foo@bar+baz.COM]
			addresses.each do |invalid_address|
				@user.email = invalid_address
				expect(@user).not_to be_valid
			end
	end

	describe "when email format is valid"
		it "should accept valid email addresses" do
			addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
			addresses.each do |valid_address|
				@user.email = valid_address
				expect(@user).to be_valid
			end
		end

	describe "when email is invalid"
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