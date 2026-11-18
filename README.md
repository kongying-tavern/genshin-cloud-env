# 空荧酒馆 · 部署环境

负责原神地图 API 各服务的容器编排、配置与启停。

## 前置条件

- Docker 与 Docker Compose
- [cargo-make](https://github.com/sagiegurari/cargo-make)（提供 `cargo make` 命令）

## 配置

首次使用复制环境变量模板：

```
cp .env.example .env
```

编辑 `.env` 填入实际值。`.env` 含密钥，已被 git 忽略，不会提交。各配置项含义见 `.env.example` 内的注释。

## 使用

运行 `cargo make` 会显示命令列表并提示选择，各命令的说明也一并列出。带 `-build` / `-run` 后缀的任务可单独执行构建或启动阶段。

## 目录结构

```
.
├── .env.example        # 环境变量模板
├── Makefile.toml       # cargo-make 任务定义
├── composer/           # 各服务的 compose 编排与 Dockerfile
├── config/             # 构建与服务配置
│   ├── api/            #   API 配置模板（渲染后写入 cache/）
│   ├── apt/            #   apt 源配置
│   ├── img-alist-builder/  # 图片服务构建素材
│   └── maven/          #   Maven 配置
├── makefile/           # cargo-make 工具脚本
└── cache/              # 运行时生成的配置（不入库）
```
