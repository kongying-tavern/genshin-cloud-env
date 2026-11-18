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

运行 `cargo make` 会显示命令列表并提示选择，各命令的说明也一并列出。带 `-build` / `-up` / `-down` 后缀的任务可单独执行构建、启动或中止阶段。

## 目录结构

```
.
├── .env.example        # 环境变量模板
├── compose.yaml        # 顶层编排，组合全部服务
├── Makefile.toml       # cargo-make 任务定义
├── assets/             # 静态资源
├── helpers/            # cargo-make 工具脚本
└── services/           # 各服务独立编排，可单独使用
    ├── _common/        #   通用资源
    │   └── config/     #     通用构建配置
    ├── _network/       #   通用网络定义
    ├── dataenv/        #   数据环境
    ├── api/            #   API 服务
    │   ├── compose/    #     Docker Compose 相关
    │   ├── templates/  #     配置模板
    │   └── .tmp/       #     渲染后的临时配置（不入库）
    ├── img-minio/      #   MinIO 相关服务
    │   ├── compose/    #     Docker Compose 相关
    │   ├── config/     #     配置
    │   ├── scripts/    #     脚本
    │   ├── src/        #     代码
    │   └── tests/      #     相关测试
    ├── minio-proxy/    #   MinIO 图片代理服务
    │   ├── compose/    #     Docker Compose 相关
    │   ├── config/     #     配置
    │   └── tests/      #     相关测试
    └── img-alist/      #   AList 相关服务
        ├── compose/    #     Docker Compose 相关
        └── scripts/    #     脚本
```
