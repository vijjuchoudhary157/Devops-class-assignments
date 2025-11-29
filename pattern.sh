#!/bin/bash

read -p "Enter size: " size
read -p "Enter type: " t

echo "---------------------------"
if [ "$t" = "t1" ]
then
    for (( i=1; i<=size; i++ ))
    do
        for (( j=size; j>i; j-- ))

        do
                echo -n " "
        done
        for (( j=1; j<=i; j++ ))

        do
                echo -n "*"
        done
        echo " "
done


elif [ "$t" = "t2" ] 
then
	for (( i=1; i<=size; i++ ))
do 
	for (( j=1; j<=i; j++ ))

	do
		echo -n "* "
	done
	echo ""
done


elif [ "$t" = "t3" ]
then
    for (( i=0; i<size; i++ ))
    do
        for (( j=0; j<size-i-1; j++ ))

        do
                echo -n " "
        done
	for (( j=0; j<2*i+1; j++ ))

        do
                echo -n "*"
        done
        echo " "
done

elif [ "$t" = "t4" ]
then
     for (( i=size; i>=1; i-- ))
do
        for (( j=i; j>=1; j-- ))

        do
                echo -n "* "
        done
        echo ""
done

elif [ "$t" = "t5" ]
then
    for (( i=size; i>=1; i-- ))
    do
        for (( j=i; j<size; j++ ))

        do
                echo -n " "
        done
        for (( j=i; j>=1; j-- ))

        do
                echo -n "*"
        done
        echo " "
done

elif [ "$t" = "t6" ]
then
    for (( i=size; i>=1; i-- ))
    do
        for (( j=size-i-1; j>=1; j-- ))

        do
                echo -n " "
        done
        for (( j=2*i+1; j>=1; j-- ))

        do
                echo -n "*"
        done
        echo " "
done
elif [ "$t" = "t7" ]
then

    for (( i=1; i<=size; i++ ))
    do
	for (( j=0; j<size-i; j++ ))

        do
                echo -n " "
        done
        for (( j=0; j<2*i-1; j++ ))

        do
                echo -n "*"
	done
		echo ""
	done

        for (( i=size-1; i>=1; i-- ))
	
        do
		for((j=0;j < size-i ; j++))
		do
               		 echo -n " "
        	done
        	for (( j=0 ; j<2*i-1; j++ ))

        	do
                echo -n "*"
        done
        echo " "
done
fi
