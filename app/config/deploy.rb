set :application, "koronka"
set :domain,      "koronka.by"
set  :user,       "root"
set  :use_sudo,   false
set :deploy_to,   "/home/koronka/public_html/www"
set :app_path,    "app"
set :web_path,    "web"

set :repository, "C:/wamp64/www/symfonynew/hello"
set :deploy_via,  :copy
set :scm, :git

set :model_manager,  "doctrine"

role :web,        domain                         # Your HTTP server, Apache/etc
role :app,        domain                         # This may be the same as your `Web` server
role :db,         domain, :primary => true       # This is where Rails migrations will run

set :shared_files,      ["app/config/parameters.yml"]
set :shared_children,     [app_path + "/logs", web_path + "/uploads"]

set :use_composer,  true
set :update_vendors, false
set  :keep_releases,  3

 task :upload_parameters do
  origin_file = "app/config/parameters.yml"
  destination_file = shared_path + "/app/config/parameters.yml" # Notice the
  shared_path

  try_sudo "mkdir -p #{File.dirname(destination_file)}"
  top.upload(origin_file, destination_file)
end

after "deploy:setup", "upload_parameters"