worker_processes 3
timeout 30
working_directory "/home/ec2-user/savitri/current"
pid "/home/ec2-user/savitri/current/tmp/pids/unicorn.pid"
listen "/home/ec2-user/savitri/current/tmp/unicorn.todo.socket"
stderr_path "/home/ec2-user/savitri/current/unicorn/err.log"
stdout_path "/home/ec2-user/savitri/current/unicorn/out.log"
preload_app false