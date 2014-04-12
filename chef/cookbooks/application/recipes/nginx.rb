package 'nginx-full'

file '/etc/nginx/sites-enabled/default' do
  action :delete
  only_if 'ls /etc/nginx/sites-enabled/default'
  manage_symlink_source true
end

template "nginx.conf" do
  owner "root"
  group "root"
  path  "/etc/nginx/nginx.conf"
  mode  "644"
  notifies :reload, "service[nginx]"
end

template "application-nginx.conf" do
  user "root"
  path "/etc/nginx/sites-available/#{node.application}.conf"
  mode "700"
  notifies :reload, "service[nginx]"
end

execute "symlink-application-config" do
  user "root"
  command "ln -s /etc/nginx/sites-available/#{node.application}.conf /etc/nginx/sites-enabled/#{node.application}.conf"
  only_if "ls /etc/nginx/sites-available/#{node.application}.conf"
  not_if "ls /etc/nginx/sites-enabled/#{node.application}.conf"
  notifies :reload, "service[nginx]"
end

service "nginx" do
  action [:enable, :start]
  only_if "ls /etc/init.d/nginx && ls /etc/nginx/sites-available/#{node.application}.conf"
end
