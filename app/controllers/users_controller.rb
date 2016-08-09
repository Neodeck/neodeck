class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @title = @user.name

    @open_graph.push({
      :prop => "title",
      :value => "#{I18n.t('x_profile', username: @user.name)} on CAH Creator"
    })

    @open_graph.push({
      :prop => "description",
      :value => I18n.t('meta_user_description', username: @user.name, deck_count: @user.decks.count)
    })

    @open_graph.push({
      :prop => "type",
      :value => "profile"
    })
  end
end
