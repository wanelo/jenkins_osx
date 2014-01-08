job_name = 'vigorish'
job_filename = "#{job_name}_config.xml"
job_config = File.join(node[:jenkins][:node][:home], '.jenkins', job_filename)

jenkins_job job_name do
  action :nothing
  config job_config
end

cookbook_file job_config do
  source    job_filename
  notifies  :update, resources(:jenkins_job => job_name), :immediately
  notifies  :build, resources(:jenkins_job => job_name), :immediately
end


