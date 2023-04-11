# Sam the Driver API

### System dependencies

    Ruby version: 3.0.0 or higher

    Bundler version: 2.4.10

### Design Considerations
1. Tech Stack:
      1. Ruby on Rails
      2. Database: SQLite3
      3. Authentication: JSON Web Token
      4. Unit Test: RSpec
2. Architecture
      1. This application is designed following the principles of Domain-Driven Design (DDD)

### Installation
 1. Clone the repository: git clone git@github.com:hoyhannah/sam-the-driver.git
 2. Install dependencies: bundle install
 3. Setup the database: rails db:setup
 4. Start the server: rails server

### Console,

    `rails c` to run Rails console

### Application Abilities

 1. Load a list of products from a file.
       `rake task to initialize products: initialize.rake`
 2. List product details to the user.
       `GET/ products`
 3. Add products to a Shopping Cart.
       `POST/ cart_items`
 4. Apply promotional discounts.
       `GET/ carts#summary`
 5. Calculate and display the total cost.
       `GET/ carts#summary`

### Usage

 1. Run rake task to initialize the products `rake products:initialize`
 2. Register using `POST/ users`
 3. Login using `POST/ login`. Take note of the generated JWT. This will be used as bearer token authorization on the endpoints you will run.
 4. Run `GET/ carts#current` with authorization using the token generated from previous item. This endpoint will retrieve your active cart details. If it does not exist, it will create a new one.
 5. To load the product list, run `GET/ products`.
 6. To add items to the cart, run `POST/ cart_items` with parameters for the item_id (can be found on item 4) and the quantity you want. Use the JWT when making this request.
 7. To see the summary and total of your cart, run `POST/ carts#summary`. It will display all the items in your cart including its name, price and quantity. Use the JWT when making this request.
    It will also display the total amount to pay. If you were eligible for a discount, an additional attribute will be displayed containing the discount rate that has been applied and the total amount before the discount.

   Note: Recommend to use postman for ready to use samples. Please see Postman Instruction

### Postman Instruction

 1. Download `Sam the Driver.postman_collection.json`
 2. Download and install Postman
 3. Open Postman and click on 'Import' button on the top left of the application.
 4. Select the downloaded json file.
 5. You can now use the endpoints on the collection for the project.

### Running the Tests

 1. Run `gem install rspec` if rspec is not yet installed.
 2. To run specific tests, run `bundle exec rspec <spec file path>`
 3. To run all tests, run `bundle exec rspec`

### Author

    Hannah Fajardo
