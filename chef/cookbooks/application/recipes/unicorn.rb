template "unicorn.init" do
  user "root"
  path "/etc/init.d/unicorn"
  mode "700"
  notifies :stop,  "service[unicorn]"
  notifies :start, "service[unicorn]"
end

service "unicorn" do
  action [:enable, :start]
  only_if "ls /etc/init.d/unicorn && ls #{node.deploy_to}/Gemfile"
end
