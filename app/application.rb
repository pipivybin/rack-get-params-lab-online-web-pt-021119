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
        if @@cart.empty?
          resp.write "Your cart is empty"
        else @@cart.each do |x|
          resp.write "#{x}\n"
        end
    elsif req.path.match(/add/)
      item = get.param[:item]
      if @@item.include?(item)
        @@cart << item
        resp.write "We just added #{item}"
      else resp.write "We don't have that item"

    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
