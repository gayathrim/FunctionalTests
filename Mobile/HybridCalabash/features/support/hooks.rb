#-----Global Hook-----


@@config = {  "host"      => ConfigReader.host,
              "username"  => ConfigReader.username,
              "password"  => ConfigReader.password,
              "database"  => ConfigReader.database,
              "port" =>ConfigReader.port}

# DbHelper.initialize(@@config)

Before('~@warmup') do |scenario|
  time = Time.now
  File.open('../../kwallet.log', 'a') { |file| file.write("Started welcome page loading: #{time.hour} #{time.min} #{time.sec} #{time.usec} \n") }

  if ENV['PLATFORM'] == 'android'
    reinstall_apps
  end
  start_test_server_in_background
end

Before('@warmup') do
 if ENV['PLATFORM'] == 'android'
  reinstall_apps
 end
 time = Time.now
 File.open('../../kwallet.log', 'a') { |file| file.write("Started welcome page loading: #{time.hour} #{time.min} #{time.sec} #{time.usec} \n") }
 start_test_server_in_background
end

After do |scenario|
  if scenario.failed?
    screenshot_embed
  end
  if ENV['PLATFORM'] == 'android'
    shutdown_test_server
  end
end

Around('@no_network') do |scenario, block|
  %x[sudo ifconfig en1 down]
  p "am here"
  sleep 5
  block.call
  %x[sudo ifconfig en1 up]
  sleep 5
end
