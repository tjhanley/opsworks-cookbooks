
node[:deploy].each do |application, deploy|
  Chef::Log.info "Setting up Walker Custom Stuff"
  Chef::Log.info "deploy: #{deploy.inspect}"
  Chef::Log.info "deploy: #{application.inspect}"
  #  setup  nginx, unicorn, sidekiq monit templates

  template File.join(node[:monit][:conf_dir],'redis.monitrc') do
    source "redis.monitrc.erb"
    cookbook 'walker'
    mode "0660"
    group deploy[:group]
    owner deploy[:user]

    only_if do
      File.exists?("#{node[:monit][:conf_dir]}")
    end
  end
end
