require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    before do
      @test_user = User.new(
        first_name: 'Some',
        last_name: 'User',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
    end

    # Happy path - All fields set properly
    it 'should validate user registration if all fields are set properly' do
      expect(@test_user).to be_valid
    end

    it 'should be invalid when password and password_confirmation do not match' do
      @test_user.password_confirmation = 'notpassword'
      expect(@test_user).not_to be_valid
      expect(@test_user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should be invalid without a password' do
      @test_user.password = nil
      expect(@test_user).not_to be_valid
      expect(@test_user.errors.full_messages).to include("Password can't be blank")
    end

    it 'should be invalid without a password confirmation' do
      @test_user.password_confirmation = nil
      expect(@test_user).not_to be_valid
      expect(@test_user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'should be invalid with a duplicate email (case-insensitive)' do
      @test_user.save
      duplicate_user = User.new(
        first_name: 'Another',
        last_name: 'User',
        email: 'TEST@test.com', 
        password: 'password',
        password_confirmation: 'password'
      )
      expect(duplicate_user).not_to be_valid
      expect(duplicate_user.errors.full_messages).to include("Email has already been taken")
    end

    it 'should be invalid without an email' do
      @test_user.email = nil
      expect(@test_user).not_to be_valid
      expect(@test_user.errors.full_messages).to include("Email can't be blank")
    end

    it 'should be invalid without a first name' do
      @test_user.first_name = nil
      expect(@test_user).not_to be_valid
      expect(@test_user.errors.full_messages).to include("First name can't be blank")
    end

    it 'should be invalid without a last name' do
      @test_user.last_name = nil
      expect(@test_user).not_to be_valid
      expect(@test_user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'should be invalid when password is too short' do
      @test_user.password = '123'
      @test_user.password_confirmation = '123'
      expect(@test_user).not_to be_valid
      expect(@test_user.errors.full_messages).to include("Password is too short (minimum is 4 characters)")
    end


  end
end

