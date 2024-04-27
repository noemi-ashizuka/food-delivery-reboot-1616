class Customer
  attr_accessor :id
  attr_reader :name, :address

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
    @address = attributes[:address]
  end

  def self.headers
    ['id', 'name', 'address']
  end

  def build_row
    [@id, @name, @address]
  end
end
