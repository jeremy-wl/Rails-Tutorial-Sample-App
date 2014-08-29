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

	describe "edit" do
	    let(:user) { FactoryGirl.create(:user) }
	    before do
	        sign_in user
	    	visit edit_user_path(user)
	    end

		describe "page" do
	  		it { should have_content("Update your profile") }
		    it { should have_title("Edit user") }
		    it { should have_link('change', href: 'http://gravatar.com/emails') }
		end

		describe "with invalid information" do
			before	{ click_button "Save changes" }

			it { should have_content("error") }
		end

		describe "with valid information" do
			let(:new_name)	{ "New Name" } 
			let(:new_email)	{ "new@new.email" }
			before do
				fill_in "Name", 		with: new_name
				fill_in "Email",		with: new_email
				fill_in "Password", 	with: user.password
				fill_in "Confirmation", with: user.password
				click_button "Save changes"
			end

			it { should have_title(new_name) }
		    it { should have_selector('div.alert.alert-success') }
		    it { should have_link('Sign out', href: signout_path) }

		    specify { expect(user.reload.name).to eq new_name }
		    specify { expect(user.reload.email).to eq new_email }

		end
	end

	describe "index" do
		let(:user) { FactoryGirl.create(:user) }
	    before(:each) do
	      sign_in user
	      visit users_path
   		end

	    it { should have_title('All users') }
	    it { should have_content('All users') }

	    describe "pagination" do

		    before(:all) { 40.times { FactoryGirl.create(:user) } }
		    after(:all)  { User.delete_all }

	        it { should have_selector('div.pagination') }

	        it "should list each user" do
		        User.paginate(page: 1).each do |user|
		       		expect(page).to have_selector('ul', text: user.name)
	        	end
	      	end
    	end
    end


end
