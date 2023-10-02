##gitを使おう

##まず、ファイルを管理したいディレクトリに移動
mkdir research/rensyu
cd research/rensyu
git init    ##自分のPCにローカルリポジトリを作成
##このコマンドはRで言うproject作るみたいなもん

##隠しファイル".git"が作られているはず。確認してみよう
ls -a
ls .git
##HEAD ... ファイルの最新版が保存されている
##objects ... ファイルの変更箇所が保存されている

##お試しファイルの作成。中身は自由
nano otamesi.sh
git status

##addが済んでいないファイルが赤文字で表記される

##addで作業ディレクトリからindexにファイルを追加
git add otamesi.sh
git status
##otamesi.shがaddされましたよと言う文が出る
##もし間違ってaddしてしまったら：
git restore --staged otamesi.sh

##次はlocal repositoryにファイルを追加
git commit -m ""
##""の中には、どんなことをしたかコメントを入れることができる
git status
git log

