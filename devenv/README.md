# 開発環境の使い方
## 実行
```
docker-compose up --build
```
## 各コンテナーに接続
```
docker-compose exec <コンテナー名>
```

## SQLコマンドの実行
```
mysql -u <ユーザー名> -p <データベース名>
```
※テーブルのマイグレーション（/init_db/init.sql）は初回Volume作成時のみ実行される
