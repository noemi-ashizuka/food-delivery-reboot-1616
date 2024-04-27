require "csv"
require_relative "../models/customer.rb"

class CustomerRepository

  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @next_id = 1
    @customers = [] # array of customers instances
    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @customers
  end

  def create(customer)
    customer.id = @next_id
    @customers << customer
    @next_id += 1
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row,header_converters: :symbol) do |row|
      # HASH crud update
      row[:id] = row[:id].to_i
      row[:address] = row[:address]

      @customers << Customer.new(row)
    end
    @next_id = @customers.last.id + 1 unless @customers.empty?
  end

  def save_csv
    CSV.open(@csv_file_path, "wb") do |csv|
      csv << ["id", "name", "address"]
      @customers.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end
end
