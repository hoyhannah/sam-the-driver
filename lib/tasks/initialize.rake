namespace :products do
  desc 'Initialize products from products.json'
  task initialize: :environment do
    file_path = './products.json'

    # Check if the file exists
    unless File.exist?(file_path)
      puts 'products.json not found'
      exit
    end

    # Read the file contents
    file = File.read(file_path)
    products = JSON.parse(file)

    # Initialize the products
    products.each do |product|
      Product.create(
        id: product['uuid'],
        name: product['name'],
        price: product['price']
      )
    end

    puts 'Products initialized!'
  end
end
