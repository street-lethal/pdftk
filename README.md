# PDFtk

## 準備

```sh
docker-compose build
```

## PDF にメタデータ追加

* .pdf ファイルを shared/ に配置
* メタデータのテキストファイル(.txt)を .pdf ファイルと同名にして shared/ に配置
* 
  ```sh
  ./scripts/exec.sh
  ```

## PDF からメタデータ抽出

* .pdf ファイルを shared/ に配置
* 
  ```sh
  ./scripts/dump.sh
  ```
