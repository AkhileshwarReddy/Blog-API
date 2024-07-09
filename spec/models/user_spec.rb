# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(user).to be_valid
    end

    it "is not valid without an email" do
      user.email = nil
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "is not valid with an invalid email format" do
      user.email = "invalid_email"
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include("Email is not valid")
    end

    it "is not valid with a duplicate email" do
      create(:user, email: user.email)
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include("has already been taken")
    end

    it "is not valid without a username" do
      user.username = nil
      expect(user).to_not be_valid
      expect(user.errors[:username]).to include("can't be blank")
    end

    it "is not valid with a duplicate username" do
      create(:user, username: user.username)
      expect(user).to_not be_valid
      expect(user.errors[:username]).to include("has already been taken")
    end

    it "is not valid without a first name" do
      user.first_name = nil
      expect(user).to_not be_valid
      expect(user.errors[:first_name]).to include("can't be blank")
    end

    it "is not valid with a first name that is too short" do
      user.first_name = "A"
      expect(user).to_not be_valid
      expect(user.errors[:first_name]).to include("is too short (minimum is 2 characters)")
    end

    it "is not valid with a first name that is too long" do
      user.first_name = "A" * 51
      expect(user).to_not be_valid
      expect(user.errors[:first_name]).to include("is too long (maximum is 50 characters)")
    end

    it "is not valid without a phone number" do
      user.phone_number = nil
      expect(user).to_not be_valid
      expect(user.errors[:phone_number]).to include("can't be blank")
    end

    it "is not valid with a duplicate phone number" do
      create(:user, phone_number: user.phone_number)
      expect(user).to_not be_valid
      expect(user.errors[:phone_number]).to include("has already been taken")
    end
  end

  describe "Callbacks" do
    it "downcases email before saving" do
      user.email = "TEST@EXAMPLE.COM"
      user.save
      expect(user.reload.email).to eq("test@example.com")
    end
  end
end
