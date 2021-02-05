# URL

https://www.medical-log.com/

# アプリケーションの画面
 
![](https://i.gyazo.com/4a27ed1d0e8ffdbf04f709696300decb.png)


# アプリケーションの概要

* 自分が経験した病気を投稿しシェアできるサービス

# アプリケーションの機能

* フォロー機能(Ajax)

* いいね機能(Ajax)

* コメント機能(Ajax)

* メールによるアカウントの有効化とパスワード再設定

* bootstrapによるレスポンシブ対応

* Dockerによる環境構築

* RSpecによるテスト記述(139example)

* awsでのデプロイ

* circleCIの導入

* rubocopの導入

* Sentryの導入

* csvの入出力

* Line、Twitterに投稿内容を共有

# 使い方

* githubからファイルをダウンロード

```
https://github.com/masatoshisugita/medical_log.git
```

* ダウンロードしたファイルに移動し、以下のコマンドでdockerのimageを作成

```
docker-compose build
```

* dockerのコンテナを作成

```
docker-compose up
```

* dockerのimageとコンテナはそれぞれ以下のコマンドで確認できる

```
docker images　#image一覧
docker ps -a  #コンテナ一覧。-aを省略すると現在起動しているコンテナのみ表示される
```

* imageとコンテナが確認できたら、DBを作成、反映する

```
docker-compose run web bundle exec rails db:create
docker-compose run web bundle exec rails db:migrate
```

* これでブラウザでlocalhost:3000にアクセスするとtopページが開く。もし開かない場合は、コンテナが起動しているか確認する。動いていなければ以下のコマンドで起動させる

```
dokcer start コンテナのID
```

* コンテナの停止

```
docker stop コンテナのID
```

 (注意　master.keyがgithub上にないため、ユーザー登録をしようとするとエラーになる)
