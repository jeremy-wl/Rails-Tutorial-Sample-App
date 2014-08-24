require 'spec_helper'

describe "UserPages" do
	
	subject	{ page }

	describe "profile page" do
		let(:user)	{ FactoryGirl.create(:user) }
		before	{ visit user_path(user) }

		it	{ should have_title(user.name) }
		it	{ should have_content(user.name) }
	end

	describe "signup page" do
		before	{ visit signup_path }

		it	{ should have_title("Sign Up") }
		it	{ should have_content("Sign Up") } 
	end

	describe "signup" do
		before	{ visit signup_path }

		describe "with invalid information" do
			it "should not create a user" do
				expect	{ click_button "Create my account" }.not_to change(User, :count)
			end
		end

		# those two "expect" methods check the "create" action which requires a "create" view, so a "create" view should be created to get the test pass ("the title in the view should get created as well")!!

		describe "with valid information" do
			it "should create a user" do
				fill_in	"Name",			with: "Jeremy"
				fill_in "Email",		with: "jwong@yahoo.com"
				fill_in "Password",		with: "linlin"
				fill_in "Confirmation",	with: "linlin"
				expect	{ click_button "Create my account" }.to change(User, :count)
			end
		end
	end

end
