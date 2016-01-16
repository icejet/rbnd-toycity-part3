class Transaction
  attr_reader :customer, :product, :id

  @@id = 1
  @@transactions = []

  def initialize(customer, product)
    @customer = customer
    @product = product
    assign_id
    reduce_stock
    add_transaction
  end

  def self.all
    @@transactions
  end

  def self.find(id)
    index = @@transactions.index do |transaction|
      transaction.id == id
    end
    @@transactions.at(index)
  end

  def self.find_by_product(title)
    @@transactions.select do |transaction|
      transaction.product.title == title
    end
  end

  def self.find_by_customer(name)
    @@transactions.select do |transaction|
      transaction.customer.name == name
    end
  end

  private

  def assign_id
    @id = @@id
    @@id += 1
  end

  def reduce_stock
    @product.stock -= 1
  end

  def add_transaction
    if @product.stock > 0
      @@transactions << self
    else
      raise OutOfStockError, "'#{@product.title}' is out of stock."
    end
  end
end
