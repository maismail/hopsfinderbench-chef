use_inline_resources

action :create_tables do
  Chef::Log.info("Tables.sql is here: #{new_resource.tables_path}")
  db="hopsxattr"
  exec = "#{node[:ndb][:scripts_dir]}/mysql-client.sh"

  bash 'create_hopsxattr_tables' do
    user "root"
    code <<-EOF
      #{exec} -e \"CREATE DATABASE IF NOT EXISTS hopsxattr CHARACTER SET latin1\"
      #{exec} #{db} -e \"source #{new_resource.tables_path}\"
    EOF
    not_if "#{exec} -e 'show databases' | grep hopsxattr"
  end

end


