class Customer
  attr_reader :name

  @@customers = []

  def initialize(options={})
    @name = options[:name]
    add_to_customers
  end

  def self.all
    @@customers
  end

  def self.find_by_name(name)
    @@customers.at(@@customers.index { |customer| customer.name == name })
  end

  def purchase(item)
    Transaction.new(self, item)
  end

  private

  def add_to_customers
    customer_exists = false
    @@customers.each do |customer|
      customer_exists = true if customer.name == @name
    end
    if customer_exists
      raise DuplicateCustomerError, "'#{@name}' already exists"
    else
      @@customers << self
    end
  end
end
