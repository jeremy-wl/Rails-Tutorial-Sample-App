# This helper tests if all the layout links direct pages to the right ones (except the root page)

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

end
