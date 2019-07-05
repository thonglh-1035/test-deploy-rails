if ENV["LOCAL_DEPLOY"]
  server "localhost", user: "deploy", roles: %w(app db)
else
  instances = fetch(:instances)

  instances.each do |role_name, hosts|
    roles = [role_name]
    hosts.each_with_index do |host, i|
      roles << "db" if i == 0
      server host, user: "deploy", roles: roles
    end
  end
end
