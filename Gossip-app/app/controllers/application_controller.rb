class ApplicationController < ActionController::Base 
  include SessionsHelper 
  include GossipsHelper
  include CommentsHelper
end
