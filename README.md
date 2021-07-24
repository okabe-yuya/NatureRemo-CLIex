# NatureRemoClient
NatureRemoのAPIをCLIから叩けるように作成しました。  
理由としては業務中や作業中にPCを触ることがメインであるため、スマホ経由からの家電操作に煩わしさを感じたためです。  

公式API
> https://swagger.nature.global/#/

## 実装
`Elixir-lang: 1.12` にて実装しました。基本的には公開されているAPIを`HTTPoison`を使って呼び出しているだけです。パターンマッチと自動ファイル読み込み & 関数呼び出し(関数名は`execute`で固定)にて簡単に拡張出来るようにしてあります。  

現在、サポートしている家電は2種類です。

- 照明
- エアコン

## 拡張
`lib/devices`直下に、対応させたい家電1つにつき、1ファイルを用意します。  
コマンド実行時に呼び出したい名前がそのままファイル名になります。  

例: リビングのテレビを追加する
```elixir
# /lib/devices/living_tv.exを作成
defmodule NatureRemoClient.Devices.Living_tv do
  :
  :
end
```

モジュール名はファイル名の先頭文字を大文字に変更したものを作成します。また`ハイフン`や`ピリオド`のような、`Elixir`にて`Atom`として使用出来ない文字は使用することが出来ません。  

作成したモジュールの中に`execute/2`という名前の関数を追加していきます。引数はコマンドラインから渡した値が以下のように対応します。  

```bash
./nature_remo_client -d "living_tv ch 5"
```

```elixir
def execute(:living_tv, ["ch", "5"])
```

第一引数には`-d`に渡した1つ目の引数が`Atom`として渡されてきます。残りの値は第二引数に`[String]`の型で受け渡されます。

## サンプル
※事前にプロジェクトをbuildして置く必要があります。  
```bash
bash escript.build.sh 
```
`nature_remo_client`というバイナリファイルが出力されます。  

※合わせて、NatureRemoのサポートページにて発行したアクセストークンを環境変数`NATURE_REMO_ACCESS_TOKEN`に記録する必要があります。  

> ~/.bash_profile
```bash
export NATURE_REMO_ACCESS_TOKEN="XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
```
> ref: https://home.nature.global/

### 照明
照明をON
```bash
> ./nature_remo_client -d "light on"
```

照明をOFF
```bash
> ./nature_remo_client -d "light off"
```

シーンをON
```bash
> ./nature_remo_client -d "light on scene"
```

常夜灯をON
```bash
> ./nature_remo_client -d "light on night"
```

### エアコン
エアコンをON
```bash
> ./nature_remo_client -d "aircon on"
```

エアコンをOFF
```bash
> ./nature_remo_client -d "aircon off"
```

エアコンを冷房に設定
```bash
> ./nature_remo_client -d "aircon set mode cool"
```

設定温度を変更
```bash
> ./nature_remo_client -d "aircon set degree 25"
```

OKBのお気に入り夏用エアコン設定に変更
(※オリジナル設定を簡単に作成出来ます😋)
```bash
> ./nature_remo_client -d "aircon set mode summer"
```