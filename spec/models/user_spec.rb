require 'rails_helper'

RSpec.describe User, :type => :model do
  describe "User" do
    it "requires a username" do
      expect(User.new(password: "password")).to be_invalid
    end

    it "requires a password" do
      expect(User.new(username: "testing")).to be_invalid
    end
  end
end
