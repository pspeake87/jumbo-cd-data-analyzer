# Unicorn PID file location
# pid "/path/to/pids/unicorn.pid"
pid "/apps/jumbocdinvestments/current/tmp/pids/unicorn.pid"

# Path to logs
# stderr_path "/path/to/log/unicorn.log"
# stdout_path "/path/to/log/unicorn.log"
stderr_path "/apps/jumbocdinvestments/current/log/unicorn.log"
stdout_path "/apps/jumbocdinvestments/current/log/unicorn.log"

# Unicorn socket
listen "/apps/jumbocdinvestments/current/tmp/sockets/unicorn.sock"
# listen "/tmp/unicorn.trophytrips.sock"

# Number of processes
worker_processes 2
# worker_processes 2

# Time-out
timeout 30