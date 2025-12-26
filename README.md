# Salt Formulas

这是一个完整的Salt Formula集合，按功能分层组织。

## 目录结构

```
salt-formulas/
├── base_*/               # 基础能力层
│   ├── base_motd/        # 系统欢迎信息
│   ├── base_sysctl/      # 内核参数配置
│   ├── base_timezone/    # 系统时区设置
│   └── base_users/       # 用户管理
├── middleware_*/         # 中间件层
│   ├── middleware_mysql/ # MySQL数据库服务器
│   ├── middleware_nginx/ # Nginx Web服务器
│   └── middleware_redis/ # Redis缓存服务器
├── runtime_*/            # 运行时层
│   ├── runtime_java/     # Java运行环境
│   └── runtime_nodejs/   # Node.js运行环境
├── app_*/                # 应用层
│   └── app_web_app/      # Web应用部署
├── scripts/              # 工具脚本
│   └── flatten_structure.rb  # 目录结构处理脚本
├── deploy.sh             # 部署脚本
├── push.rb               # 推送脚本
├── Rakefile              # Rake任务定义
└── top.sls               # Formula执行拓扑
```

## Formula使用说明

### 1. 基础层 (base_*)

#### motd
设置系统欢迎信息。

**Pillar配置**:
```yaml
motd:
  message: "Welcome to this server"  # 欢迎信息内容
```

#### sysctl
配置内核参数。

**Pillar配置**:
```yaml
sysctl:
  net.core.somaxconn: 65535
  vm.max_map_count: 262144
```

#### timezone
设置系统时区。

**Pillar配置**:
```yaml
timezone:
  name: Asia/Shanghai    # 时区名称
  utc: true             # 是否使用UTC
```

#### users
管理系统用户。

**Pillar配置**:
```yaml
users:
  appuser:
    uid: 1001
    gid: 1001
    home: /home/appuser
    shell: /bin/bash
    groups:
      - docker
    password: hashed_password
```

### 2. 中间件层 (middleware_*)

#### mysql
部署和配置MySQL数据库服务器。

**Pillar配置**:
```yaml
mysql:
  root_password: changeme     # root用户密码
  database: myapp             # 默认数据库名
  user: myapp                 # 默认用户名
  password: changeme          # 默认用户密码
  host: localhost             # 绑定地址
  port: 3306                  # 监听端口
  max_connections: 100        # 最大连接数
```

#### nginx
部署和配置Nginx Web服务器。

**Pillar配置**:
```yaml
nginx:
  worker_processes: 4
  worker_connections: 1024
  listen_port: 80
  server_name: example.com
  root_dir: /usr/share/nginx/html
```

#### redis
部署和配置Redis缓存服务器。

**Pillar配置**:
```yaml
redis:
  port: 6379
  bind: 127.0.0.1
  max_memory: 256mb
  max_memory_policy: allkeys-lru
  appendonly: yes
  requirepass: your_password
```

### 3. 运行时层 (runtime_*)

#### java
安装Java运行环境。

**Pillar配置**:
```yaml
java:
  version: openjdk17  # 可选: openjdk8, openjdk11, openjdk17
```

#### nodejs
安装Node.js运行环境。

**Pillar配置**:
```yaml
nodejs:
  version: nodejs     # Node.js包名
  npm_version: npm    # NPM包名
```

### 4. 应用层 (app_*)

#### web-app
部署Web应用。

**Pillar配置**:
```yaml
web_app:
  name: myapp
  version: 1.0.0
  port: 3000
  host: 0.0.0.0
  environment: production
  user: myapp
  group: myapp
  root: /opt/myapp
  exec_start: /usr/bin/node app/index.js
  database:
    host: localhost
    port: 3306
    name: myapp
    user: myapp
    password: changeme
  redis:
    host: localhost
    port: 6379
```

## 在KkOps中使用

1. **添加Formula仓库**:
   ```
   Formula管理 → 仓库管理 → 添加仓库
   Git地址: https://github.com/your-org/salt-formulas.git
   分支: master
   ```

2. **同步Formula**:
   ```
   点击仓库列表中的"同步"按钮
   系统会自动发现和注册所有Formula
   ```

3. **部署Formula**:
   ```
   Formula部署页面
   - 选择Formula (如 nginx)
   - 配置参数
   - 选择目标主机
   - 执行部署
   ```

## 开发新Formula

### 标准Formula结构

```
category_your-formula/
├── init.sls          # 入口文件
├── install.sls       # 安装逻辑 (可选)
├── config.sls        # 配置管理 (可选)
├── service.sls       # 服务控制 (可选)
├── deploy.sls        # 部署逻辑 (可选)
├── env.sls           # 环境变量 (可选)
├── map.jinja         # 参数映射 (可选)
├── files/            # 配置文件模板 (可选)
│   └── config.j2
└── README.md         # 说明文档 (可选)
```

### 命名约定

- **基础层**: `base_{功能名}` (如: base_timezone)
- **中间件层**: `middleware_{服务名}` (如: middleware_nginx)
- **运行时层**: `runtime_{环境名}` (如: runtime_java)
- **应用层**: `app_{应用名}` (如: app_web_app)

### 最佳实践

1. **职责单一**: 每个Formula只做一件事
2. **参数化**: 使用Pillar传递配置参数
3. **幂等性**: 确保多次执行结果一致
4. **依赖管理**: 明确声明依赖关系
5. **测试覆盖**: 为关键功能编写测试

## 许可证

MIT License