#!/bin/bash

echo Write \"I am the brainwasher\" as fast as you can \(still in less than 5 seconds\)

read -n 1 c

start=$(date +%s)

read -n 19 iao

end=$(date +%s)
time=$(( end-start ))

if [ $time -gt 5 ]; then
	echo
	echo "I'm sorry, you were too slow."
	exit
fi

echo
echo "Let's see what did you write..."

if [ "$c" == "I" ]; then

	if [ "$iao" == "am the brainwasher" ]; then
		echo You did it! Awesome!
	else
		echo Sorry, the sentence is wrong. "(2)"
		exit
	fi
else
	echo Sorry, the sentence is wrong. "(1)"
	exit
fi

echo You wrote \"$c $iao\" in $time seconds

