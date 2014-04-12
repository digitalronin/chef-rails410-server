# See http://unicorn.bogomips.org/Unicorn/Configurator.html for complete
# documentation.
# See also http://unicorn.bogomips.org/examples/unicorn.conf.rb for
# a more verbose configuration using more features.
#
# Run unicorn with;  bundle exec unicorn -c unicorn.conf.rb  
#
ENV['RACK_ENV'] = 'production'
# listen 8080 # by default Unicorn listens on port 8080
listen "/home/appuser/hello/tmp/unicorn.sock", :backlog => 64
worker_processes 4 # this should be >= nr_cpus
pid "/home/appuser/hello/tmp/unicorn.pid"
stderr_path "/home/appuser/hello/log/unicorn.log"
stdout_path "/home/appuser/hello/log/unicorn.log"
