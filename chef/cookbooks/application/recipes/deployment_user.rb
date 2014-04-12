deployment_user = node[:deployment_user]
if deployment_user == "root"
  ssh_dir = "/root/.ssh"
else
  ssh_dir = "/home/#{deployment_user}/.ssh"
end

directory ssh_dir do
  user deployment_user
  mode "700"
end

cookbook_file "bitbucket_known_hosts" do
  user  deployment_user
  group deployment_user
  path "#{ssh_dir}/known_hosts"
  only_if "ls -d #{ssh_dir}"
end

# Allow passwordless access as the deployment user
cookbook_file "authorized_keys" do
  user  deployment_user
  group deployment_user
  path  "#{ssh_dir}/authorized_keys"
end
