class MainController < ApplicationController
  def index
    @open_graph.push({
      :prop => "title",
      :value => "Welcome"
    })

    @open_graph.push({
      :prop => "description",
      :value => "Make your own Cards Against Humanity decks in realtime with friends, then play with them in a game of CAH!"
    })
  end

  def faq
    @open_graph.push({
      :prop => "title",
      :value => "CAH Creator FAQ"
    })

    @open_graph.push({
      :prop => "description",
      :value => "You should really read this before asking a question."
    })
  end
end
