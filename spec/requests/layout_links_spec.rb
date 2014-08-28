# This helper tests if all the layout links direct pages to the right ones (except the root page)

# Request specs provide a thin wrapper around Rails' integration tests, and are
# designed to drive behavior through the full stack, including routing
# (provided by Rails) and without stubbing (that's up to you).
# With request specs, you can:
# specify a single request
# specify multiple requests across multiple controllers
# specify multiple requests across multiple sessions


require 'spec_helper'

describe "LayoutLinks" do

	it "should have a home page at '/'" do
		visit '/'
		expect(page).to have_title("Home")	#indicating that it is on the Home page
	end

	it "should have a Contact page at '/contact'" do
		visit '/contact'
		expect(page).to have_title("Contact")
		# response.should have_selector('title', :content => "Contact")
	end

	it "should have a Help page at '/help" do
		visit '/help'
		expect(page).to have_title("Help")
	end

	it "should have an About page at /about" do
		visit '/about'
		expect(page).to have_title("About")
	end

	it "should have a Sign Up title" do
		visit "/signup"
		expect(page).to have_title("Sign Up")		
	end

	

	before(:each) do
		visit root_path
	end

#The before block is supposed to run before all tests that follow, so it has to go outside of the it blocks. If the code is specific to one scenario, just remove the before since it's not really doing anything.

	it "should have the right links on the layout" do

			expect(page).to have_title("Home")		
			click_link("About")
			expect(page).to have_title("About")
			click_link("Contact")
			expect(page).to have_title("Contact")
			visit root_path		    
			click_link("Sign Up")				
			expect(page).to have_title("Sign Up")
			
			within("header") do
				click_link("Help")
				expect(page).to have_title("Help")
			end

			within ("footer") do 
				click_link("Help")
				expect(page).to have_title("Help")
			end

			# expect(page).to have_selector("a[href='/'] > img")	# meaning there's an anchor along with an href attribute where there is an img tag inside
	end

#The test won't pass with this line cuz it's not on the layout page??
end