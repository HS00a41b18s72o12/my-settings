## プロジェクト内で使われている Pip ライブラリを取得して requirements.txt を作成する
```bash
pipreqs --encoding UTF8 . --force
```

## ログの設定
```python
def set_logging(current_path, log_dir):
    log_file = os.path.join(current_path, log_dir, datetime.now().strftime("%Y-%m-%d") + ".log")
    logging.basicConfig(
        level=logging.INFO,
        format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
        handlers=[
            logging.FileHandler(filename=log_file, mode="a", encoding="UTF-8")
        ]
    )
```