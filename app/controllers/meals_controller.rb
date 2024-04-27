require_relative "../views/meals_view.rb"

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @meals_view = MealsView.new
  end

  def list
    display_meals
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

  	def edit
	  display_meals
	  index = @meals_view.ask_for('number').to_i - 1
	  meal = @meal_repository.all[index]
	  meal.name = @meals_view.ask_for('new name')
	  meal.price = @meals_view.ask_for('new price').to_i
	  @meal_repository.update
	end

	def destroy
	  display_meals
	  index = @meals_view.ask_for('number').to_i - 1
	  @meal_repository.destroy(index)
	end

  private

  def display_meals
    # ask the repository for all the meals
    meals = @meal_repository.all
    # ask the view to display the meals
    @meals_view.display(meals)
  end
end