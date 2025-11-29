#!/bin/bash
echo " This will tell if a number is divisible by 3 , 5 or 15 "
echo "--------------------------------------------------------"
echo " tom -> If number is divisible by 3"
echo " cat -> If number is divisible by 5"
echo " tomcat -> If number is divisible by 15"

echo "-------------------------------------------------------"
read -p "Enter the number: " number

if (( number % 3 == 0 ))
then 
	echo "tom"
elif (( number % 5 == 0 ))
then
	echo "cat"
elif (( number % 15 == 0 ))
then
	echo "tomcat"
else 
	echo "not divisible by any of the three numbers"
fi
