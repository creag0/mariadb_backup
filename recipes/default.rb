#
# Cookbook Name:: mariadb_backup
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Create database backup file
execute 'db_dump' do 
	command "mysqldump -u#{node[:mariadb_backup][:db_username]} --password=#{node[:mariadb_backup][:db_password]} #{node[:mariadb_backup][:db_name]}  > #{node[:mariadb_backup][:db_backup_location]}/data-dump.sql"

end

# Add time and date stamp to backup
execute 'time_and_date_stamp' do
	command "mv #{node[:mariadb_backup][:db_backup_location]}/data-dump.sql #{node[:mariadb_backup][:db_backup_location]}/#{node[:mariadb_backup][:time_stamp]}.data-dump.sql" 
end

# Clean up old backups  

execute "remove_old_backups" do
	command "find #{node[:mariadb_backup][:db_backup_location]} -type f -ctime +30 -exec rm -f {} \\;"
end