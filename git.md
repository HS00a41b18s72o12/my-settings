## git checkout --orgit のコミット履歴をすべて消す（現時点の状態の1コミットだけにする）
#### 親を共有しないブランチを作成し、コミット、その後 master ブランチのコミット履歴を tmp で上書きし、tmp ブランチを削除
```bash
git checkout --orphan tmp
git commit -m "Initial Commit"
git checkout -B main
git branch -d tmp
```


## 強制 push 
```
git push -f origin main
```

## 強制 push するけど自身のリモートよりもローカルが最新ではない場合は pushしない
```
git push --force-with-lease origin main
```

## 特定のファイルの変更履歴を確認する
```
git log --word-diff -p .\function\common.py
```