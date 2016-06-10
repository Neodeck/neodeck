class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @title = @user.name

    @open_graph.push({
      :prop => "title",
      :value => "#{@user.name}'s Profile on CAH Creator"
    })

    @open_graph.push({
      :prop => "description",
      :value => "Come look at #{@user.name}'s #{@user.decks.count} decks on CAH Creator"
    })

    @open_graph.push({
      :prop => "type",
      :value => "profile"
    })
  end
end
