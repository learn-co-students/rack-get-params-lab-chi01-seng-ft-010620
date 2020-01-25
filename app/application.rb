class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)

    elsif req.path.match(/cart/)
      if @@cart.length == 0
        resp.write "Your cart is currently empty."
      else @@cart.each do |item|
        resp.write "Your cart currently contains #{item}.\n"
        end
      end
    elsif req.path.match(/add/)
      item_to_add = req.params["item"]
      resp.write handle_add(item_to_add)
    else
      resp.write "Path Not Found"
    end

    response.finish
  end

    def handle_add(item_to_add)
      if @@items.include?(item_to_add)
        @@cart << item_to_add
        return "#{item_to_add} has been added to your cart.\n"
      else
        return "#{item_to_add} is not included in our inventory. Please see the items page for a comprehensive list of items."
      end
    end

    def handle_search(search_term)
      if @@items.include?(search_term)
        return "#{search_term} is one of our items"
      else
        return "Couldn't find #{search_term}"
      end
    end
end
