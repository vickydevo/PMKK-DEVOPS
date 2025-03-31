
AWK usage  AWK Req formatted data csv, tsv . 
 

AWK: A more powerful tool designed for data extraction and reporting. 
   It processes input line by line but treats each line as a record and 
   each word or column as a field, making it ideal for working with structured data 
   (like columns in a CSV file). AWK allows for more complex operations involving pattern matching, 
   arithmetic, and generating formatted reports.

# get first 3 three line in log file
  head -3 sam.log
  head -n sam.log
# print all content in file
awk '{print}' sam.log

# if want only first 2 coloums in those lines
awk '{print $2,$3,$4,$5}' awk_sed_grep.sh

# if want specific word in a line
 awk '/DEBUG/ {print $1,$2, $5}' LOGFILE-name
 awk '/INFO/ {print $1,$2, $5}'
# GET the count of INFO
awk '/INFO/ {count++}' app.log   --> no display
awk '/INFO/ {count++} END {print count}' app.log
 awk '/INFO/ {count++} END {print "The count of INFO is", count}' app.log
 awk '/9.67.116.98/ {count++} END {print "The count of IP(9.67.116.98) is",'count'}' sam.log
 
 # if i get specific time incident at some time
 awk '{print $2}' sam.log
 
 awk '$2 >= "08:51:06" && $2 <= "08:52:50" {print $2,$3,$4}' app.log
# no of rows
   awk ' {print NR}' app.log
   awk 'NR >= 2 && NR <= 7 {print NR}' app.log
   awk 'NR >= 2 && NR <= 7 {print NR, $2, $3 }' app.log

sed (Stream EDitor): Primarily used for simple text transformations and pattern-based editing.
      It works line by line, applying specified transformations to each line, 
      such as substitution, deletion, insertion, and pattern matching.
# sed usage unformating data. works on line by line data
# sreach for INFO line in sed

   sed -n '/INFO/p' sam.lo  
  # -n it tells sed not to print every line by default 
  # p Tells sed to print only the lines that match the pattern. 


# replace the string

      sed  's/INFO/LOG/g' sam.log
#  s substitute from entire
#  g globally, meaning it will replace all occurrences of "INFO" on each line, 
#       not just the first occurrence.

#  INFO is in which line no
sed -n -e '/INFO/=' sam.log
   -n: Suppresses automatic printing of pattern space, 
        meaning it will only print lines when explicitly told to.
   -e '/INFO/=': This tells sed to execute the command that follows, which is /INFO/=.
   /INFO/: A pattern that matches any line containing "INFO".
    =: This command prints the line number of lines that match the pattern.
# i wanna print LINE also along with line no

   sed -n -e '/INFO/=' -e '/INFO/p' sam.log

# If you also want to see the matching lines (along with their line numbers), use this command:
   sed -n -e '/INFO/=' -e '/INFO/p' sam.log

   sed '1,20 s/INFO/VIGNAN---LOG/g; 1,10p;11q ' sam.log

# 1,20: Specifies a range of lines, from line 1 to line 20.
# q: Quits the script after processing the 11th line.



grep is a command-line tool used to search for specific patterns of text within files or output. 
   It scans each line of input, looks for matches to the specified pattern, and outputs those matching lines.
   grep is commonly used for filtering and searching, 
   making it essential for tasks involving pattern recognition in text files.


grep -i  INFO sam.log
grep -i info sam.log
  
 grep -ic info sam.log
 awk '/INFO/ {count++}END {print count}' sam
.log 

in all processess i want some 

ps aux | grep ubuntu



































































awk '/awk/ {for(i=2; i<=10; i++)print $i}' awk_sed_grep.sh
 
  ansible --version | grep config | awk '{print $2}'
  awk '$2 >= "08:51:06" && $2 <= "08:52:50" {print $2,$3,$4}' app.log

