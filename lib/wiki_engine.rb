module WikiEngine
  def self.draw_routes(map)
    map.resources :wiki_pages, :collection => {:preview => :put}
  end
end
