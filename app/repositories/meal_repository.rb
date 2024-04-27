require "csv"
require_relative "../models/meal.rb"

class MealRepository

  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @next_id = 1
    @meals = [] # array of meals instances
    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @meals
  end

  def create(meal)
    meal.id = @next_id
    @meals << meal
    @next_id += 1
    save_csv
  end

  def update
	  save_csv
	end

	def destroy(index)
	  @meals.delete_at(index)
	  save_csv
	end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row,header_converters: :symbol) do |row|
      # HASH crud update
      row[:id] = row[:id].to_i
      row[:price] = row[:price].to_i

      @meals << Meal.new(row)
    end
    @next_id = @meals.last.id + 1 unless @meals.empty?
  end

  def save_csv
    CSV.open(@csv_file_path, "wb") do |csv|
      csv << ["id", "name", "price"]
      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end
end
