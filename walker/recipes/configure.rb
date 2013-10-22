node[:deploy].each do |application, deploy|
  Chef::Log.info "Setting up Walker Custom Stuff"
  Chef::Log.info "deploy: #{deploy.inspect}"
  Chef::Log.info "deploy: #{application.inspect}"

  service "rsyslog" do
    action :restart
  end

end
