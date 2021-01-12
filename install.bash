#!/bin/bash

GOINFRE=/goinfre/$USER
BREW_PATH=$GOINFRE/.brew
BREW_OLD=$HOME/.brew
BREW_EXEC=$BREW_PATH/bin/brew
if [ ! -d $BREW_PATH ]; then
	if [ -d $BREW_OLD ]; then
		rm -rf $BREW_OLD
	fi
	git clone https://github.com/Homebrew/brew $BREW_PATH
fi



ZSHRC_FILE=$HOME/.zshrc
IFS=$'\n' read -d '' -r -a lines < $ZSHRC_FILE
if [ -f $ZSHRC_FILE ]; then 
		rm -rf $ZSHRC_FILE & touch $ZSHRC_FILE
	else
		touch $ZSHRC_FILE
fi
for i in "${lines[@]}"; do 
	if [[ "$i" == *"brew"*  ]]; then
		echo 'export PATH=$HOME/goinfre/.brew/bin:$PATH' >> $ZSHRC_FILE
	else
		echo $i >> $ZSHRC_FILE
	fi
done

if [[ "${lines[@]}" =~ "Code" ]] || [[ "${lines[@]}" =~ "code" ]]; then
	echo exist
else
	echo 'export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"' >> $ZSHRC_FILE
fi

brew update
brew install minikube
cd 
mv .minikube goinfre/
ln -s goinfre/.minikube .
minikube start
