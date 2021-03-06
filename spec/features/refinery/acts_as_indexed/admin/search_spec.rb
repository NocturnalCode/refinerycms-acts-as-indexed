require "spec_helper"

module Refinery
  describe "search", :type => :feature do
    refinery_login_with :refinery_user

    shared_examples "no result search" do
      it "returns no results" do
        fill_in "search", :with => "yada yada"
        click_button "Search"
        expect(page).to have_content("Sorry, no results found")
      end
    end

    describe "images extension" do
      let!(:image) { FactoryGirl.create(:image) }
      before do
        visit refinery.admin_images_path
      end

      it "returns found image" do
        fill_in "search", :with => "beach"
        click_button "Search"

        within ".actions" do
          expect(page).to have_selector("a[href*='#{image.image_name}']")
        end
      end

      it_behaves_like "no result search"
    end

    describe "resources extension" do
      before do
        FactoryGirl.create(:resource)
        visit refinery.admin_resources_path
      end

      it "returns found resource" do
        fill_in "search", :with => "refinery"
        click_button "Search"
        expect(page).to have_content("Refinery Is Awesome.txt")
      end

      it_behaves_like "no result search"
    end

    describe "pages extension" do
      before do
        FactoryGirl.create(:page, :title => "Ugis Ozols")
        visit refinery.admin_pages_path
      end

      it "returns found page" do
        fill_in "search", :with => "ugis"
        click_button "Search"
        expect(page).to have_content("Ugis Ozols")
      end

      it_behaves_like "no result search"
    end

    describe "users extension" do
      before do
        FactoryGirl.create(:user, :username => "ugis")
        visit refinery.admin_users_path
      end

      it "returns found user" do
        fill_in "search", :with => "ugis"
        click_button "Search"
        expect(page).to have_content("ugis")
      end

      it_behaves_like "no result search"
    end
  end
end
