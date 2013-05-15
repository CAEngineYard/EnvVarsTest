class ApplicationController < ActionController::Base

  require 'socket'

  protect_from_forgery

  def production_mode_permission
    permission = ipLookup
    #puts "ENTERING production_mode_permission..."
    #raw_config = File.read(CONFIG_PATH + "run_mode_config.yml")
    #config_yml = YAML::load( raw_config )
    #permission = (config_yml['run_mode'].eql? 'production')
    #puts "config_yml['run_mode']:[#{config_yml['run_mode']}]"
    #if(config_yml['run_mode'].eql? 'production')
    #puts "config_yml['run_mode'].eql? 'production' PASSED."
    #end
    return permission
  end

  def ipLookup
    my_ip = local_ip
    puts "IP ADDRESS: #{my_ip.to_s}"
    permission = ! (my_ip[0..6].eql? "10.10.3")
  end

  def local_ip
    orig, Socket.do_not_reverse_lookup = Socket.do_not_reverse_lookup, true  # turn off reverse DNS resolution temporarily

    UDPSocket.open do |s|
      s.connect '64.233.187.99', 1
      s.addr.last
    end
  ensure
    Socket.do_not_reverse_lookup = orig
  end

end
