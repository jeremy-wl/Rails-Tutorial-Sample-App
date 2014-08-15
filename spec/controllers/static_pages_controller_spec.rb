require 'spec_helper'

describe StaticPagesController do 
  render_views

  describe "Get 'home'" do

    it "should be success" do
      get 'home'
      response.should be_success
    end

    it "should have a non-blank body" do
      get 'home'
      response.body.should_not =~ /<body>\s*<\/body>/
    end
  
  end


  describe "Get 'contact'" do

    it "should be success" do
      get 'contact'
      response.should be_success
    end


  end

  describe "Get 'help'" do

    it "should be success" do
      get 'help'
      response.should be_success
    end

  end

  describe "Get 'about'" do

    it "should be success" do
      get 'about'
      response.should be_success
    end
  
  end


end