require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    it 'should be a valid user' do
      @user = User.new(
        first_name: 'first_name',
        last_name: 'last_name',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      @user.save

      expect(@user).to be_valid
    end

    it 'should not validate without a first name' do
      @user = User.new(
        first_name: nil,
        last_name: 'last_name',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      @user.save

      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'should not validate without a last name' do
      @user = User.new(
        first_name: 'first_name',
        last_name: nil,
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      @user.save

      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'should not validate without an email' do
      @user = User.new(
        first_name: 'first_name',
        last_name: 'last_name',
        email: nil,
        password: 'password',
        password_confirmation: 'password'
      )
      @user.save

      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'should not validate if passwords do not match' do
      @user = User.new(
        first_name: 'first_name',
        last_name: 'last_name',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'pass'
      )
      @user.save

      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should not validate if passwords do not match' do
      @user = User.new(
        first_name: 'first_name',
        last_name: 'last_name',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: nil
      )
      @user.save

      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'should not validate if password length is not minimum 8 characters' do
      @user = User.new(
        first_name: 'first_name',
        last_name: 'last_name',
        email: 'test@test.com',
        password: 'pass',
        password_confirmation: 'pass'
      )
      @user.save

      expect(@user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end

    it 'should not validate if password length is not minimum 8 characters' do
      @user = User.new(first_name: 'first_name', last_name: 'last_name', email: 'TEST@TEST.com', password: 'password', password_confirmation: 'password')
      @user.save

      @user2 = User.new(first_name: 'first_name', last_name: 'last_name', email: 'test@test.COM', password: 'password', password_confirmation: 'password')
      @user2.save

      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

  end

  describe '.authenticate_with_credentials' do
    it 'should log the user in' do
      @user = User.create(first_name: 'first_name', last_name: 'last_name', email: 'test@test.com', password: 'password', password_confirmation: 'password')
      @user.save
      @user = User.authenticate_with_credentials('test@test.com', 'password')

      expect(@user).not_to be nil
    end

    it 'should log the user in when the emails are in different cases' do
      @user = User.create(first_name: 'first_name', last_name: 'last_name', email: 'test@test.com', password: 'password', password_confirmation: 'password')
      @user.save
      @user = User.authenticate_with_credentials('TEST@test.COM', 'password')

      expect(@user).to be_truthy
    end

    it 'should log the user in when the email has trailing spaces' do
      @user = User.create(first_name: 'first_name', last_name: 'last_name', email: 'test@test.com', password: 'password', password_confirmation: 'password')
      @user.save
      @user = User.authenticate_with_credentials('  test@test.com  ', 'password')

      expect(@user).to be_truthy
    end

    it 'should not log the user in when password is incorrect' do
      @user = User.create(first_name: 'first_name', last_name: 'last_name', email: 'test@test.com', password: 'password', password_confirmation: 'password')
      @user.save
      @user = User.authenticate_with_credentials('test@test.com', 'pass')

      expect(@user).to be_falsy
    end
  end
end

