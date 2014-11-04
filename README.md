# RS4NNCT

NNCT(www.nara-k.ac.jp)用の科目推薦システム

## 使い方

### 1. リポジトリをクローンする

    $ git clone https://github.com/KeiHotman/rs4nnct
    $ cd rs4nnct

### 2. Bundleでgemを入れる。

オプションでpathを付けるとrs4nnct/vendor/bundle以下にインストールされるよ。

    $ bundle install --path vendor/bundle

### 3. DBをこさえる

    $ bundle exec rake db:create db:migrate

### 4. 初期データ入れる

[奈良高専公式サイト](http://www.nara-k.ac.jp/)からシラバスの[PDF(2014/11/4時点での場所)](http://www.nara-k.ac.jp/education/2011/05/)のZIPを取ってきて所定のディレクトリに解凍する。


    $ mkdir -p db/seeds/syllabus/(年度)
    $ unzip ~/Downloads/downloaded_syllabus.zip -d db/seeds/syllabus/(年度)

解凍したPDFの入ったディレクトリ名は以下の例のようにしてください。

例.
* 1年情報工学科 => 1I
* 2年機械工学科 => 2M
* 3年電気工学科 => 3E
* 4年物質化学工学科 => 4C
* 5年電子制御工学科 => 5S
* 専攻科1年化学工学専攻科 => 1AC
* 専攻科2年電子情報工学専攻 => 2AEI
* 専攻科2年機械制御工学専攻 => 2AMS

使用するシラバスを全て用意できたら、次のコマンドで初期データをDBに投入。

    $ bundle exec rake db:seed version=syllabus

### 5. サーバを起動して使ってみる

    $ bundle exec rails s

ブラウザを起動し、[localhost:3000](localhost:3000)にアクセスする。


## 機能

いろいろ用意したけど、あとで書く。コード見るかメッセージ下さい。

アクセスできるルートは、

    $bundle exec rake routes

で確認できるよ。



