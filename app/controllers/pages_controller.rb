class PagesController < ApplicationController
  before_action :authenticate_user!, only: [ :home ]
  def welcome
  end
  def home
    @chats = current_user.chats
  end
end
