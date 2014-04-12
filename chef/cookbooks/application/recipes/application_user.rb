# setup a user account for our application
application_user = node[:application_user]
application_home = "/home/#{application_user}"

user_exists = "id #{application_user}"

execute "create user #{application_user}" do
  user "root"
  command "useradd #{application_user} -d #{application_home}"
  not_if user_exists
end

directory application_home do
  user application_user
  mode "755"
end
