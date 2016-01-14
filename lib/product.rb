class Product
  attr_reader :title

  @@products = []

  def initialize(options={})
    @title = options[:title]
    add_to_products
  end

  def self.all
    @@products
  end

  private

  def add_to_products
    product_exists = false
    @@products.each do |product|
      product_exists = true if product.title == @title
    end
    if product_exists
      raise DuplicateProductError, "#{@title} already exists."
    else
      @@products << self
    end
  end
end
