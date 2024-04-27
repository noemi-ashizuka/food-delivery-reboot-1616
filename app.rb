# require_relative "app/models/meal.rb"
# require_relative "app/repositories/meal_repository.rb"

# p Meal.new(name: "burritos", price: "1000")

# csv_file = "data/meals.csv"

# p MealRepository.new(csv_file)

require_relative "app/repositories/meal_repository.rb"
require_relative "app/controllers/meals_controller.rb"
require_relative "app/repositories/customer_repository.rb"
require_relative "app/controllers/customers_controller.rb"
require_relative "router.rb"

# csv_file = File.join(__dir__, "data/meals.csv")
csv_file = "data/meals.csv"
meal_repository = MealRepository.new(csv_file)
meals_controller = MealsController.new(meal_repository)

csv_file = "data/customers.csv"
customer_repository = CustomerRepository.new(csv_file)
customers_controller = CustomersController.new(customer_repository)


router = Router.new(meals_controller, customers_controller)


router.run
