hcmpl ハッカーズチャンプルー用ハッシュタグのツイートを垂れ流す君
============

### 実行環境用意

cpanmは入ってますか？

$ cpanm -v

入っていない場合はインストールします。

Downloading the standalone executable

You can also copy the standalone executable to whatever location you'd like.

    cd ~/bin
    curl -LO http://xrl.us/cpanm
    chmod +x cpanm


cartonは入ってますか？

$ carton -v

入っていない場合はインストールします。

cpanm Carton

依存モジュールをインストールします。

$ carton install


### 設定ファイルを用意

$ cp config.yml.default config.yml

して、中身を埋めます。

cs_key: 'APIキー'

cs_secret: 'APIシークレットキー'

ac_token: 'アクセストークン'

ac_secret: 'アクセストークンシークレット'

track: '拾いたいハッシュタグ'



### サーバを起動します。

carton exec plackup -Ilib












