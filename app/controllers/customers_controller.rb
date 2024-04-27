require_relative "../views/customers_view.rb"
require_relative "../models/customer.rb"

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @customers_view = CustomersView.new
  end

  def list
    # ask the repository for all the customers
    customers = @customer_repository.all
    # ask the view to display the customers
    @customers_view.display(customers)
  end

  def add
    # ask the user for a name and store it
    name = @customers_view.ask_for("name")
    # ask the user for a price and store it
    address = @customers_view.ask_for("address")
    # create a new customer instance
    customer = Customer.new(name: name, address: address)
    # add the customer to the repository
    @customer_repository.create(customer)
  end
end