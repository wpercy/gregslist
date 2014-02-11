class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  after_filter :store_history
  include SessionsHelper

  private

  	def store_history
  		session[:history] ||=[]
  		session[:history].delete_at(0) if session[:history].size >= 5
  		session[:history] << request.url 
  	end
end