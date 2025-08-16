# CLAUDE.md

このファイルは、このリポジトリでコードを扱う際にClaude Code (claude.ai/code) にガイダンスを提供します。

## リポジトリ概要

これは、基盤となるプロジェクト構造と設定ファイルを提供することを目的とした、ベースボイラープレートテンプレートリポジトリです。このリポジトリは、事前設定された開発ツールとワークフローを備えた新しいプロジェクトの出発点として機能します。

## コード品質とリンティング

このリポジトリでは、コード品質の強制にpre-commitフックを使用しています。以下のコマンドを実行してください：

```bash
# pre-commitフックをインストール
pre-commit install

# すべてのpre-commitフックを手動実行
pre-commit run --all-files

# 特定のフックを実行
pre-commit run <hook-name>
```

### 利用可能なpre-commitフック

- **ファイル検証**: check-json、check-yaml、check-added-large-files
- **セキュリティ**: detect-aws-credentials、detect-private-key
- **フォーマット**: end-of-file-fixer、trailing-whitespace、mixed-line-ending
- **YAMLリンティング**: yamllint
- **スペルチェック**: cspell（cspell.json設定を使用）
- **Markdownリンティング**: markdownlint-cli2（自動修正付き）
- **日本語テキストリンティング**: 日本語固有のルールを持つtextlint
- **シェルスクリプトリンティング**: shellcheck
- **GitHub Actions**: actionlint、ワークフローファイル用prettier
- **Terraform**: terraform_fmt
- **Renovate**: renovate-config-validator

## スペルチェック

リポジトリでは、`cspell.json`にカスタム辞書を持つcspellをスペルチェックに使用しています。辞書には、プロジェクト固有の用語、ツール、開発で一般的に使用される固有名詞が含まれています。

## 依存関係管理

- **Renovate**: 依存関係の自動更新は`renovate.json5`を通じて設定され、`github>tqer39/renovate-config`から拡張されています

## GitHub ワークフローと自動化

リポジトリには以下のGitHub Actionsワークフローが含まれています：

- **Pre-commit**: mainブランチへのプッシュとプルリクエストで実行
- **Auto-assign**: kentaro-m/auto-assign-actionを使用してPR作成者を自動割り当て
- **Labeler**: ファイルパターンに基づいてPRを自動ラベル付け（editorconfig、document、terraform、textlint、yamllint、markdownlint、asdf、actionlint、CODEOWNERSをサポート）
- **ライセンス年更新**: 自動化されたライセンス年のメンテナンス

## プロジェクト構造

- `.github/`: GitHub固有の設定（ワークフロー、CODEOWNERS、テンプレート）
- `.editorconfig`: 一貫したコードフォーマットのためのエディタ設定
- `.pre-commit-config.yaml`: pre-commitフック設定
- `cspell.json`: スペルチェッカー設定とカスタム辞書
- `renovate.json5`: 依存関係更新自動化設定

## コード所有権

- グローバルコードオーナー: @tqer39（CODEOWNERSで定義）

## 開発ワークフロー

1. pre-commitフックはコミット時に自動実行されます
2. プルリクエストは作成者に自動割り当てされます
3. PRは変更されたファイルに基づいて自動ラベル付けされます
4. マージ前にすべてのpre-commitチェックが通過する必要があります
5. Renovateが依存関係更新のPRを自動作成します
