#!/bin/sh
rm -rf test
rm -rf list_*
rm -rf man.txt
rm -rf man.dir
#1
mkdir test

#2
cd test
ls -R -a -q /etc > list 

#3
find /etc -type -d | wc -l >> list
find /etc -type f -name ".*" | wc -l >> list

#4
mkdir links

#5
cd links
ln ../list list_hlink

#6
ln -s ../list list_slink

#7
cnt_hlink=$(ls -l list_hlink | awk '{print $2}')
cnt_slink=$(ls -l list_slink | awk '{print $2}')
cnt_link=$(ls -l ../list | awk '{print $2}')
echo "count hard links list_hlink = $cnt_hlink,"
echo "count hard links list_slink = $cnt_slink,"
echo "count hard links list = $cnt_link"

#8
(cat ../list | wc -l | awk '{print $1}') >> list_hlink

#9
if cmp -s list_slink list_hlink;
then
	echo "Yes.9"
else
	echo "No.9"
fi 

#10
cd ~/test/
mv list list1

#11 
if cmp -s list_slink list_hlink;
then 
	echo "Yes.11"
else
	echo "No.11"
fi

#12
cd ~
ln ~/test/list1 list_link

#13
find /etc -name '*.conf' > list_conf

#14
find /etc -maxdepth 1 -name "*.d" > list_d

#15
cat list_conf > list_conf_d
cat list_d >> list_conf_d

#16
cd test
mkdir .sub

#17
cp ../list_conf_d .sub

#18
cp -b ../list_conf_d .sub

#19
cd
echo "All files $(ls -a -R test)"

#20
man man > man.txt

#21
split -b 1K man.txt

#22
mkdir man.dir

#23
mv x* man.dir/

#24
cd man.dir
cat x* > man.txt

#25
if cmp -s ~/man.txt man.txt;
then 
	echo "Yes.25"
else
	echo "No.25"
fi

#26
cd
sed -i "1s/^/ Hello \n My friend\n/" man.txt
echo -e "Bay! \n My friend" >> man.txt

#27
diff -u man.dir/man.txt man.txt > patch.txt

#28 
mv patch.txt man.dir/

#29
cd man.dir
patch -s man.txt < patch.txt

#30 
cd
if cmp -s man.txt man.dir/man.txt;
then 
	echo "Yes.30"
else
	echo "No.30"
fi
