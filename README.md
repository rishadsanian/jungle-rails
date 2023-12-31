# Jungle

A mini e-commerce application project setup to simulate real world on the job experience. This is an app built with Ruby on Rails and uses RSpec and Cypress for Testing.

## Implemented Project Requirements

### Functional Requirements

#### Feature: Sold Out Badge
- Major: When a product has 0 quantity, a sold out badge should be displayed on the product list page
- Minor: Should ideally be implemented as a question/boolean method in view helper and/or Product model

#### Feature: Admin Categories
- Major: Admin users can list and create new categories
- Major: Admins can add new products using the new category
- Major: Implement new Dashboard category so that Admins can view products and category summary
- Major: Restful routes (resources) should be used, and there should be no extra, unused routes exposed
- Bonus: All admin controllers inherit from Admin::BaseController (or similarly named) abstract controller, containing the authentication filter

#### Feature: User Authentication
- Major: As a Visitor, I can go to the registration page from any page in order to create an account
- Major: As a Visitor, I can sign up for a user account with my e-mail, password, first name, and last name
- Major: As a Visitor, I can sign in using my e-mail and password
- Major: As a User, I can log out from any page
- Major: As a User, I cannot sign up with an existing e-mail address (uniqueness validation)
- Major: Passwords are not stored as plain text in the database. Instead, `has_secure_password` is used in the User model, leveraging the bcrypt gem

#### Enhancement: Order Details Page
- Major: The order page contains items, their image, name, description, quantities, and line item totals
- Major: The final amount for the order is displayed
- Minor: The email that was used to place the order is displayed
- Minor: As a Visitor, I can place an order (i.e. without logging in and therefore without an e-mail address). The original functionality from the inherited code (even though it is not realistic) should therefore not be suppressed.

#### Bug: Missing Admin Security
- Major: User must enter HTTP auth login/password to access admin functionality
- Bonus: Should ideally be implemented in an abstract top-level class for admin controllers (e.g., Admin::BaseController which the other concrete admin controllers inherit)

#### Bug: Checking Out with Empty Cart
- Major: When the cart is empty and the user goes to the carts#show page, instead of displaying the contents and a stripe checkout button, display a friendly message about how it is empty and link to the home page

#### Feature: About Page
- Major: Implemented an About Page with Nav-bar links.

#### Bug: Money Formatting
- Format money values with a $ sign where missing.

### Tests and Sepecs Implementation - RSpec and Cypress

#### Model Spec - Product
- Tests implemented for testing validations in Product Model

#### Model Spec - User
- Setup testing validations for User Model
- Adjusted code to ensure minimum password length
- Adjusted code to eliminate edge cases during user login and account registration

### Feature Spec - HomePage
 - Ensure display of expected contents in Homepage

### Feature Spec - Product Details
- Ensure proper navigation from the homepage to the correct product details page ensuring modularity in testing.

### Feature Spec - Add to Cart
- Ensure users can click the 'Add to Cart' button for a product on the home page and in doing so their cart increases by one.

## Setup

1. Run `bundle install` to install dependencies
2. Create `config/database.yml` by copying `config/database.example.yml`
3. Create `config/` by copying `config/secrets.example.yml`
4. Run `bin/rails db:reset` to create, load and seed db
5. Create .env file based on .env.example
6. Sign up for a Stripe account
7. Put Stripe (test) keys into appropriate .env vars
8. Run `bin/rails s -b 0.0.0.0` to start the server

## Database

If Rails is complaining about authentication to the database, uncomment the user and password fields from `config/database.yml` in the development and test sections, and replace if necessary the user and password `development` to an existing database user.

## Stripe Testing

Use Credit Card # 4111 1111 1111 1111 for testing success scenarios.

More information in their docs: <https://stripe.com/docs/testing#cards>

## Dependencies

- Rails 6.1 [Rails Guide](http://guides.rubyonrails.org/v6.1/)
- Bootstrap 5
- PostgreSQL 9.x
- Stripe
