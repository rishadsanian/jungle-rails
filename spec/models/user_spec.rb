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

  describe '.authenticate_with_credentials' do
    before do
      @test_user = User.create(
        first_name: 'Some',
        last_name: 'User',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
    end

    it 'should return current_user as test_user with correct credentials' do
      current_user = User.authenticate_with_credentials('test@test.com', 'password')
      expect(current_user).to eq(@test_user)
    end

    it 'should return nil for invalid username' do
      current_user = User.authenticate_with_credentials('wrongemail@test.com', 'password')
      expect(current_user).to be_nil
    end
  
    it 'should return nil for invalid password' do
      current_user = User.authenticate_with_credentials('test@test.com', 'wrong_password')
      expect(current_user).to be_nil
    end

    it 'should ignore surrounding whitespaces in email' do
      current_user = User.authenticate_with_credentials('  test@test.com  ', 'password')
      expect(current_user).to eq(@test_user)
    end
  
    it 'should ignore case in email when authenticating' do
      current_user = User.authenticate_with_credentials('TEST@test.COM', 'password')
      expect(current_user).to eq(@test_user)
    end

  end
  

end

