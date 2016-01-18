require 'rails_helper'

RSpec.describe Game, :type => :model do
  describe "Game" do 
    it "requires a name" do
      expect(Game.new(map: '1,1,1,1')).to be_invalid
    end

    it "requires a map" do
      expect(Game.new(name: 'Testing')).to be_invalid
    end
  end
end
