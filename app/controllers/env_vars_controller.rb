class EnvVarsController < ApplicationController

  def index
    if Rails.env.development?
      @env = ENV["WEBSVC_URL_DEV"]
      @dev = ENV["PARTNERID_DEV"]
    end
    if Rails.env.test?
      @env = ENV["WEBSVC_URL_TEST"]
    end

    if Rails.env.production? && production_mode_permission
      @env =    ENV["WEBSVC_URL_PROD"]
      @dev = ENV["PARTNERID_PROD"]
    else
      @env = ENV["WEBSVC_URL_DEV"]
      @dev = ENV["PARTNERID_DEV"]
    end
    return @env
  end

end
