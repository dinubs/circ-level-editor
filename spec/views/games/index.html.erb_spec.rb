require 'rails_helper'

RSpec.describe "games/index", :type => :view do
  before(:each) do
    assign(:games, [
      Game.create!(
        :name => "Name",
        :slug => "Slug",
        :map => "Map",
        :completions => 1
      ),
      Game.create!(
        :name => "Name",
        :slug => "Slug",
        :map => "Map",
        :completions => 1
      )
    ])
  end

  it "renders a list of games" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
    assert_select "tr>td", :text => "Map".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
