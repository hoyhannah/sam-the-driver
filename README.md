# README

* Ruby version

    ruby 3.0.0

* System dependencies

    Install `ruby`, `bundler`, `sqlite3`

* Configuration

* Database creation

    Created cart, cart_items, product table

* Database initialization

    rails db:create db:migrate db:seed

* Install

    git clone git@github.com:hoyhannah/sam-the-driver.git

    cd sam-the-driver

* Console, Serve

    `rails c` to run Rails console

    `rails server` to run the server

* Application Abilities

  1. Load a list of products from a file.
        `GET/ carts#summary`
  2. List product details to the user.
        `GET/ products`
  3. Add products to a Shopping Cart.
        `POST/ cart_items`
  4. Apply promotional discounts.
        `GET/ carts#summary`
  5. Calculate and display the total cost.
        `GET/ carts#summary`

* How to use

  Note: Will provide postman examples to test on your local

  1. Register using `POST/ users`
  2. Login using `POST/ login`. Take note of the generated jwt token.
  3. Run `GET/ carts#current` with authorization using the token generated from previous item. This endpoint will retrieve your active cart details. If it does not exist, it will create a new one.
  4. To load the product list, run `GET/ products`.
  5. To add items to the cart, run `POST/ cart_items` with parameters for the item_id (can be found on item 4) and the quantity you want.
  6. To see the summary and total of your cart, run `POST/ carts#summary`. It will display all the items in your cart including its name, price and quantity.
    It will also display the total amount to pay. If you were eligible for a discount, an additional attribute will be displayed containing the discount rate that has been applied and the total amount before the discount.
