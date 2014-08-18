# it renders the view's in the controller spec. If you don't put render_views, the views won't render, that means the controller is called but after it returns the views are not rendered. Controller tests will run faster, as they won't have to render the view, but you might miss bugs in the view.

require 'spec_helper'

describe UsersController do
    render_views


  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end

    it "should have the right title" do
      visit signup_path
    	expect(page).to have_title("Sign Up")
    end

  end

end