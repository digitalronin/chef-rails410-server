template "sshd_config" do
  owner "root"
  group "root"
  path  "/etc/ssh/sshd_config"
  mode  "644"
  notifies :restart, "service[ssh]"
end

service "ssh"
