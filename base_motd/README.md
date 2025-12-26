# MOTD Formula

配置服务器登录欢迎信息（Message of the Day）。

## 可配置参数

通过 Pillar 传入：

```yaml
motd:
  message: 'Welcome to Production Server!'  # 欢迎信息
  show_hostname: true                        # 显示主机名
  show_date: true                            # 显示更新时间
  admin_email: 'ops@company.com'            # 管理员邮箱
```

## 使用示例

```bash
# 默认配置
salt 'web-*' state.apply base_motd

# 自定义消息
salt 'web-*' state.apply base_motd pillar='{"motd": {"message": "Production Server", "admin_email": "ops@test.com"}}'
```
