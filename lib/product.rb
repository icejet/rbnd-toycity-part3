class Product
  attr_reader :title, :price
  attr_accessor :stock

  @@products = []

  def initialize(options = {})
    @title = options[:title]
    @price = options[:price]
    @stock = options[:stock]
    add_to_products
  end

  def in_stock?
    @stock > 0
  end

  def self.all
    @@products
  end

  def self.find_by_title(title)
    @@products.at(@@products.index { |product| product.title == title })
  end

  def self.in_stock
    @@products.select { |product| product.stock > 0 }
  end

  private

  def add_to_products
    product_exists = false
    @@products.each do |product|
      product_exists = true if product.title == @title
    end
    if product_exists
      raise DuplicateProductError, "'#{@title}' already exists."
    else
      @@products << self
    end
  end
end
