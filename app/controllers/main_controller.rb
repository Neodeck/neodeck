class MainController < ApplicationController
  def index
    @open_graph.push({
      :prop => "title",
      :value => I18n.t('welcome')
    })

    @open_graph.push({
      :prop => "description",
      :value => I18n.t('site_description')
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
