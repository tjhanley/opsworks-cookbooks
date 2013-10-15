# Instillation
default[:redis][:version]         = '2.6.14'
default[:redis][:source_checksum] = '2ef8ea6a67465b6c5a5ea49241313d3dbc0de11b'
default[:redis][:install_dir]     = '/usr/local'
default[:redis][:conf_dir]        = '/etc/redis'
default[:redis][:db_dir]          = '/srv/redis'

# Service user & group
default[:redis][:user]  = 'redis'
default[:redis][:group] = 'redis'

# Config
default[:redis][:daemonize]                   = 'yes'
default[:redis][:pid_file]                    = '/var/run/redis_6379.pid'
default[:redis][:port]                        = 6379
default[:redis][:bind_address]                = '127.0.0.1'
default[:redis][:timeout]                     = 0
default[:redis][:keepalive]                   = 60
default[:redis][:log_level]                   = 'notice'
default[:redis][:log_file]                    = '/var/log/redis.log'
default[:redis][:databases]                   = 16
default[:redis][:activerehashing]             = 'yes'
default[:redis][:stop_writes_on_bgsave_error] = 'yes'
default[:redis][:rdbcompression]              = 'yes'
default[:redis][:rdbchecksum]                 = 'yes'
default[:redis][:dbfilename]                  = 'dump.rdb'
default[:redis][:slave_serve_stale_data]      = 'yes'
default[:redis][:slave_read_only]             = 'yes'
default[:redis][:repl_disable_tcp_nodelay]    = 'no'
default[:redis][:slave_priority]              = 100
default[:redis][:appendonly]                  = 'no'
default[:redis][:appendfsync]                 = 'everysec'
default[:redis][:no_appendfsync_on_rewrite]   = 'no'
default[:redis][:auto_aof_rewrite_percentage] = 100
default[:redis][:auto_aof_rewrite_min_size]   = '64mb'
default[:redis][:lua_time_limit]              = 5000
default[:redis][:slowlog_log_slower_than]     = 10000
default[:redis][:slowlog_max_len]             = 128
default[:redis][:snapshot_saves]              = [
  { 900 => 1 },
  { 300 => 10 },
  { 60 => 10000 }
]
