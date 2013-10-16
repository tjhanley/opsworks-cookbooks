execute 'add custom lines' do
  app_name = node[:deploy].keys.first
  command "echo '##############################\n\tApp Directory: cd #{node[:deploy][app_name][:current_path]}\n\tAccess rails console: sudo RAILS_ENV=#{node[:deploy][app_name][:rails_env]} bundle exec rails c\n\tTail production logs: sudo tail -f /srv/www/#{app_name}/shared/log/production.log\n##############################\n' >> /etc/motd.opsworks-static"
end



