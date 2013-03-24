worker_processes 3
timeout 30
working_directory "~/projects/savitri"
pid "~/projects/savitri/tmp/pids/unicorn.pid"
stderr_path "~/savitri/unicorn/err.log"
stdout_path "~/savitri/unicorn/out.log"
listen "~/projects/savitri/tmp/unicorn.todo.socket"