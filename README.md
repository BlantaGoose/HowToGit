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
##もしくは、以下のgit logも便利
git log --oneline --graph
##HEAD→〇〇、origin/〇〇という表示が出る。
##HEADはローカルリポジトリ、mainはリモートを表すß

##このshell自体もgitへ送ってみる。以下はメモ
##Terminal上で以下のコマンド
git add HowToGit.sh
git status

git commit -m "ForTheFirstTimeYouUseGit"
git log
##その後、ブラウザで自分のgithubページへ行き、新しいリモートリポジトリを作成
##名前（とコメント）を入力し、Publicを選択、create repositoryをクリック→URLをコピー
git remote add origin "https://github.com/BlantaGoose/HowToGit.git"

##error: remote origin already exists.
##と言われたら、git remote rm origin

git push -u origin master
##error: src refspec master does not match any
##2020/10以降、新規リポジトリの名前はmasterではなくmainになったらしい

##もしくは以前作っていたリモートリポジトリに追加したい
git remote -v   ##どんなのがあるのか確認




##以上が、ローカル→リモートの方向性
##では、リモート→ローカルでは？
##git fetch：リモート→ローカルに取り込む。ローカルの.git/内のみが変更されている
##git merge：fetchで取れてきた内容を手元のファイルに反映させる
##git pullはfetchとmergeのみ。

git fetch
git log --oneline --graph --all
##HEADとoriginが位置する行が異なるのが見えるはず。
git merge
git log --oneline --graph
nano otamesi.sh
##HEADとoriginが同じ行に並んだ。確かにotamesi.shもリモートのものが反映された
##HEADをoriginに追いつかせる（localでは何の変更も加えていないmerge）を、fast forward merge

##一方、HEADでも変更を行なっていて、localとremoteの変更を一つに統合する必要があるとき→non-fast forward mergeという。
##そのままfetchとmergeをすると、重複部分はどちら（localかremoteか）の変更を優先させるか？となるのでconflict発生！！
nano otamesi.sh     ##12行目にThis line is edited local.という文
##マイページでotamesi.shに別の文を入れてみる。
git add otamesi.sh
git commit -m "Update otamei.sh local"
git fetch
git commit
##エラー文が出てくるはず
git log --oneline --graph --all
##HEADとoriginが分岐している！！
##では、otamesi.shの中身を見てみよう
nano otamesi.sh
##<<<<<<<< HEAD
##This line is edited local.
##=========
##This line is also edited online.
##>>>>>>>>> refs/remotes/origin/main

##CONFLICTを解決するためには、otamesi.shを直すしかない。
git add otamesi.sh
git commit -m "Solve a conflict" 
git log --oneline --graph --all
##分岐が元に戻ってるはず。しかし、originがHEADに追いついていないので、
git push