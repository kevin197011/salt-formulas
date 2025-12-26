# MySQL Formula

安装和配置 MySQL 数据库服务器。

## 支持的操作系统

- Debian/Ubuntu
- RHEL/CentOS

## 可配置参数

通过 Pillar 传入配置参数：

```yaml
mysql:
  config:
    # 网络设置
    port: 3306                    # MySQL 端口
    bind_address: '127.0.0.1'     # 绑定地址，'0.0.0.0' 允许远程连接

    # 连接设置
    max_connections: 151          # 最大连接数
    max_allowed_packet: '64M'     # 最大数据包大小

    # InnoDB 设置
    innodb_buffer_pool_size: '256M'   # InnoDB 缓冲池大小
    innodb_log_file_size: '64M'       # InnoDB 日志文件大小
    innodb_flush_log_at_trx_commit: 1 # 事务提交时刷新日志

    # 字符集
    character_set_server: 'utf8mb4'
    collation_server: 'utf8mb4_unicode_ci'

    # 慢查询日志
    slow_query_log: true
    slow_query_log_file: '/var/log/mysql/slow.log'
    long_query_time: 2            # 慢查询阈值（秒）
```

## 使用示例

### 基本安装（使用默认配置）

```bash
salt 'db-server' state.apply middleware_mysql
```

### 自定义配置

创建 Pillar 文件 `/srv/pillar/mysql.sls`：

```yaml
mysql:
  config:
    bind_address: '0.0.0.0'
    max_connections: 500
    innodb_buffer_pool_size: '1G'
```

然后执行：

```bash
salt 'db-server' state.apply middleware_mysql pillar='{"mysql": {"config": {"max_connections": 500}}}'
```

## 文件结构

```
middleware_mysql/
├── init.sls          # 主入口
├── install.sls       # 安装包
├── config.sls        # 配置文件
├── service.sls       # 服务管理
├── map.jinja         # 参数映射
├── files/
│   └── my.cnf.j2     # 配置模板
└── README.md
```
