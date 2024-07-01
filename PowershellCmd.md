## PowershellスクリプトでPythonを実行する
```bash
py "C:\app.py"
```
## batファイルでPowerShellを実行する
```bash
PowerShell -File "C:\startup.ps1"
```
## cmdでPowershellコマンドを実行する
```bash
PowerShell -Command "py C:\app.py"
```
スタートアップのフォルダにbatファイルを格納することでOS起動時にpyやps1を実行できる
