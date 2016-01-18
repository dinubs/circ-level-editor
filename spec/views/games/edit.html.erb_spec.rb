require 'rails_helper'

RSpec.describe "games/edit", :type => :view do
  before(:each) do
    @game = assign(:game, Game.create!(
      :name => "MyString",
      :slug => "MyString",
      :map => "MyString",
      :completions => 1
    ))
  end

  it "renders the edit game form" do
    render

    assert_select "form[action=?][method=?]", game_path(@game), "post" do

      assert_select "input#game_name[name=?]", "game[name]"

      assert_select "input#game_slug[name=?]", "game[slug]"

      assert_select "input#game_map[name=?]", "game[map]"

      assert_select "input#game_completions[name=?]", "game[completions]"
    end
  end
end
