class Admin::StoresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_store, only: [:edit]
	layout 'backend'

  def index
    @stores = current_user.stores.all
  end
  def edit

  end
  private
  def set_store
    @store = Store.find params[:id]
  end
end
