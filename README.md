# ai-edge-contest-6

ベースは、
[第6回AIエッジコンテスト　ハードウェアリファレンス](https://github.com/basaro/AIEDGE6)
を元に対応しています。

追加の対応としては
$ source 3_makeacc.sh

を実行後に
$ source 3_5_makepfm2.sh
を実行してください。

vitis/riscv_ex/imports/hls/prj/sol/impl/misc/drivers/riscv_v1_0/src フォルダ内に 
riscv 操作用のコードが生成されるので
アプリ側で使用する場合は、生成されたコードを元に対応してください。

