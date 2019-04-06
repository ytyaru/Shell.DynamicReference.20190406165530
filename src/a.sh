#!/bin/bash
#set -Ceu # 配列・連想配列の動的参照で「未割り当ての変数です」と怒られる
#-----------------------------------------------------------------------------
# bashで変数を動的参照する（配列・連想配列も）
# 作成日時: 2019-04-06T16:58:15+0900
#-----------------------------------------------------------------------------
Run() {
	FUNCS=(VarNomal VarReplace VarEval ArrayNomal ArrayReplace ArrayEval AssociativeArrayNomal AssociativeArrayReplace AssociativeArrayEval)
	COUNT=${#FUNCS[@]}
	echo $COUNT
	for item in "${FUNCS[@]}"; do { echo "-----${item}----"; eval ${item};  }; done;
	#for item in ${FUNCS[@]}; do { echo "-----${item}----"; eval ${item};  }; done;
	#for i in ${FUNCS[@]}; do { echo "-----${i}----"; eval ${i};  }; done;
	#for i in ${FUNCS[@]}; do { echo "-----${i}----"; eval ${i}; ((i++)); }; done;
	#for ((i=0; i<${COUNT}; i++)); do { echo "-----${i}: ${FUNCS[${i}]}-----"; eval ${FUNCS[${i}]}; }; done;
	#なぜかAssociative系の直前で止まったので手動実行する。
#	AssociativeArrayNomal
#	AssociativeArrayReplace
#	AssociativeArrayEval
#	VarNomal
#	VarReplace
#	VarEval
#	ArrayNomal
#	ArrayReplace
#	ArrayEval
#	AssociativeArrayNomal
#	AssociativeArrayReplace
#	AssociativeArrayEval
}
VarNomal() {
	AGE=20
	echo "${AGE}"
}
VarReplace() {
	VNAME=AGE
	AGE=20
	echo "${!VNAME}"
}
VarEval() {
	VNAME=AGE
	AGE=20
	eval echo '$'${VNAME}
}
ArrayNomal() {
	AGES=( 11 22 33 )
	echo ${AGES[1]}
}
ArrayReplace() {
	AGES=( 11 22 33 )
	VNAME=AGES
	echo "${!VNAME[1]}"
	# set -Ceu     !VNAME[1]: 未割り当ての変数です
}
ArrayEval() {
	AGES=( 11 22 33 )
	VNAME=AGES
	eval echo '${'"${VNAME}"'[1]}'

	COUNT=$(eval echo '${#'"${VNAME}"'[@]}')
	echo $COUNT
	for ((i=0; i<$COUNT; i++)); do eval echo '${'"${VNAME}"'['"$i"']}'; done;
}
AssociativeArrayNomal() {
	declare -A Human=([Name]=Yamada [Age]=55)
	echo ${Human[Name]}
	echo ${Human[Age]}
}
AssociativeArrayReplace() {
	declare -A Human=([Name]=Yamada [Age]=55)
	VNAME=Human
	echo "${!VNAME[Name]}"
	echo "${!VNAME[Age]}"
	# set -Ceu     Name, Age: 未割り当ての変数です
}
AssociativeArrayEval() {
	declare -A Human=([Name]=Yamada [Age]=55)
	VNAME=Human
	eval echo '${'"${VNAME}"'[Name]}'
	eval echo '${'"${VNAME}"'[Age]}'

	COUNT=$(eval echo '${#'"${VNAME}"'[@]}')
	echo $COUNT
	KEYS="$(eval echo '${!'"${VNAME}"'[@]}')"
	echo "$KEYS"
	for key in $KEYS; do eval echo '${'"${VNAME}"'['"$key"']}'; done;
}
Run
