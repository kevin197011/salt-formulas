# Salt Formulas

这是一个完整的Salt Formula集合，按功能分层组织。

## 目录结构

```
salt-formulas/
├── base/                 # 基础能力层
│   ├── timezone/        # 系统时区设置
│   ├── users/           # 用户管理
│   └── sysctl/          # 内核参数配置
├── middleware/          # 中间件层
│   ├── nginx/           # Nginx Web服务器
│   └── redis/           # Redis缓存服务器
├── runtime/             # 运行时层
│   ├── java/            # Java运行环境
│   └── nodejs/          # Node.js运行环境
├── app/                 # 应用层
│   └── web-app/         # Web应用部署
└── top.sls              # Formula执行拓扑
```

## Formula使用说明

### 1. 基础层 (base)

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

#### sysctl
配置内核参数。

**Pillar配置**:
```yaml
sysctl:
  net.core.somaxconn: 65535
  vm.max_map_count: 262144
```

### 2. 中间件层 (middleware)

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

### 3. 运行时层 (runtime)

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

### 4. 应用层 (app)

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
    port: 5432
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
your-formula/
├── init.sls          # 入口文件
├── install.sls       # 安装逻辑
├── config.sls        # 配置管理
├── service.sls       # 服务控制
├── map.jinja         # 参数映射
└── files/            # 配置文件模板
    └── config.j2
```

### 最佳实践

1. **职责单一**: 每个Formula只做一件事
2. **参数化**: 使用Pillar传递配置参数
3. **幂等性**: 确保多次执行结果一致
4. **依赖管理**: 明确声明依赖关系
5. **测试覆盖**: 为关键功能编写测试

## 许可证

MIT License