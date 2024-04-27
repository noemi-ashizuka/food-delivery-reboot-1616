require_relative "../views/meals_view.rb"

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @meals_view = MealsView.new
  end

  def list
    # ask the repository for all the meals
    meals = @meal_repository.all
    # ask the view to display the meals
    @meals_view.display(meals)
  end

  def add
    # ask the user for a name and store it
    name = @meals_view.ask_for("name")
    # ask the user for a price and store it
    price = @meals_view.ask_for("price").to_i
    # create a new meal instance
    meal = Meal.new(name: name, price: price)
    # add the meal to the repository
    @meal_repository.create(meal)
  end
end