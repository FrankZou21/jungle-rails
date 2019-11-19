require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "Initiallizes properly" do
      user = User.create(:first_name => "Frank", :last_name => "Zou", :email => "frankzou2000@hotmail", :password => "12345", :password_confirmation => "12345")
      expect(user).to be_valid
    end

    it "Cannot create user if password and password_confirmation field not the same" do
      user = User.create(:first_name => "Frank", :last_name => "Zou", :email => "frankzou2000@hotmail", :password => "12345", :password_confirmation => "1")
      expect(user.errors.full_messages[0]).to eq "Password confirmation doesn't match Password"
    end

    it "Cannot create user if email is not unique" do
      user1 = User.create(:first_name => "Frank", :last_name => "Zou", :email => "frankzou2000@hotmail", :password => "12345", :password_confirmation => "12345")
      user2 = User.create(:first_name => "Frank", :last_name => "Zou", :email => "Frankzou2000@hotmail", :password => "12345", :password_confirmation => "12345")
      expect(user2.errors.full_messages[0]).to eq "Email has already been taken"
    end

    it "Cannot create user if no email" do
      user = User.create(:first_name => "Frank", :last_name => "Zou", :password => "12345", :password_confirmation => "12345")
      expect(user.errors.full_messages[0]).to eq "Email can't be blank"
    end

    it "Cannot create user if no first name" do
      user = User.create(:last_name => "Zou", :email => "frankzou2000@hotmail", :password => "12345", :password_confirmation => "12345")
      expect(user.errors.full_messages[0]).to eq "First name can't be blank"
    end

    it "Cannot create user if no last name" do
      user = User.create(:first_name => "Frank", :email => "frankzou2000@hotmail", :password => "12345", :password_confirmation => "12345")
      expect(user.errors.full_messages[0]).to eq "Last name can't be blank"
    end

    it "Password length must be between 4 and 20" do
      user = User.create(:first_name => "Frank", :last_name => "Zou", :email => "frankzou2000@hotmail", :password => "123", :password_confirmation => "123")
      expect(user.errors.full_messages[0]).to eq "Password is too short (minimum is 4 characters)"
    end
  end

  describe '.authenticate_with_credentials' do
    it "Can login" do
    user = User.create(:first_name => "Frank", :last_name => "Zou", :email => "frankzou2000@hotmail", :password => "12345", :password_confirmation => "12345")
    login = User.authenticate_with_credentials("frankzou2000@hotmail", "12345")
    expect(login.first_name).to eq "Frank"
    end

    it "Can login with spaces in front of email" do
      user = User.create(:first_name => "Frank", :last_name => "Zou", :email => "frankzou2000@hotmail", :password => "12345", :password_confirmation => "12345")
      login = User.authenticate_with_credentials("   frankzou2000@hotmail", "12345")
      expect(login.first_name).to eq "Frank"
    end
    
    it "Can login with case insensitive" do
      user = User.create(:first_name => "Frank", :last_name => "Zou", :email => "eXample@domain.COM", :password => "12345", :password_confirmation => "12345")
      login = User.authenticate_with_credentials("EXAMPLe@DOMAIN.CoM", "12345")
      expect(login.first_name).to eq "Frank"
    end
  end


end

