class ClientsController < ApplicationController
  before_action :require_user, only: [:upload]
  def home
  end
  def upload
  end
  def browse
  end
  def tutorial
  end
end
