#!/bin/sh
echo "CALCULATOR"
echo "-------------------"
echo " "
read -p "Enter number 1: " a
read -p "Enter number 2: " b
echo "-------------------"
echo " "
echo "SELECT AN OPERATOR"
read -p "Enter operators ( '+', '-' , '*' , '/' ): " operator
echo "-------------------"
echo " "
echo "Result is : "
if [ $operator = '+' ] 
then
	add=$((a+b))
	echo $add
elif [ $operator = '-' ]
then
	sub=$((a-b))
	echo $sub
elif [ $operator = '*' ]
then 
	mul=$((a*b))
	echo $mul
else
	div=$((a/b))
	echo $div
fi
