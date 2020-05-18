# アプリケーションの概要

* 自分が経験した病気を投稿しシェアできるサービス

# アプリケーションの機能

* フォロー機能(Ajax)

* いいね機能(Ajax)

* コメント機能(Ajax)

* メールによるアカウントの有効化

* bootstrapによるレスポンシブ対応

* Dockerによる環境構築

* RSpecによるテスト記述(104example)

* awsでのデプロイ

* circleCIの導入

# 使い方

* githubからファイルをダウンロード

```
https://github.com/masatoshisugita/medical_log.git
```

* ダウンロードしたファイルに移動し、以下のコマンドでdockerのimageとコンテナを作成

```
docker-compose build
```

* dockerのimageとコンテナはそれぞれ以下のコマンドで確認できる

```
docker images　# image一覧
docker ps -a # コンテナ一覧。-aを省略すると現在起動しているコンテナのみ表示される
```
もしコンテナが無ければ、docker-compose upでコンテナを作成する

* imageとコンテナが確認できたら、DBを作成、反映する

```
docker-compose run web bundle exec rails db:create
docker-compose run web bundle exec rails db:migrate
```
* これでブラウザでlocalhost:3000にアクセスするとtopページが開く。もし開かない場合は、コンテナが起動しているか確認する。動いていなければ以下のコマンドで起動させる
```
dokcer start コンテナのID
```
コンテナを停止させるには「start」を「stop」に変えればよい

