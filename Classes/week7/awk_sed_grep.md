# AWK, SED, and GREP Usage Guide

This document provides an overview and examples of using **AWK**, **SED**, and **GREP** for text processing and data extraction.

---

## AWK

**AWK** is a powerful tool designed for data extraction and reporting. It processes input line by line, treating each line as a record and each word or column as a field. This makes it ideal for working with structured data like CSV or TSV files. AWK supports complex operations such as pattern matching, arithmetic, and generating formatted reports.

### Examples

#### Basic Operations
- **Print all content in a file:**
   ```bash
   awk '{print}' sam.log
   ```

- **Print specific columns:**
   ```bash
   awk '{print $2, $3, $4, $5}' awk_sed_grep.sh
   ```

- **Search for a specific word in a line:**
   ```bash
   awk '/DEBUG/ {print $1, $2, $5}' LOGFILE-name
   awk '/INFO/ {print $1, $2, $5}'
   ```

#### Counting Matches
- **Count occurrences of "INFO":**
   ```bash
   awk '/INFO/ {count++} END {print count}' app.log
   awk '/INFO/ {count++} END {print "The count of INFO is", count}' app.log
   ```

- **Count occurrences of a specific IP:**
   ```bash
   awk '/9.67.116.98/ {count++} END {print "The count of IP(9.67.116.98) is", count}' sam.log
   ```

#### Filtering by Time
- **Extract incidents within a specific time range:**
   ```bash
   awk '$2 >= "08:51:06" && $2 <= "08:52:50" {print $2, $3, $4}' app.log
   ```

#### Line Numbers
- **Print line numbers:**
   ```bash
   awk '{print NR}' app.log
   ```

- **Print specific line ranges:**
   ```bash
   awk 'NR >= 2 && NR <= 7 {print NR, $2, $3}' app.log
   ```

---

## SED (Stream Editor)

**SED** is primarily used for simple text transformations and pattern-based editing. It processes input line by line, applying transformations such as substitution, deletion, insertion, and pattern matching.

### Examples

#### Searching
- **Search for lines containing "INFO":**
   ```bash
   sed -n '/INFO/p' sam.log
   ```

#### Substitution
- **Replace "INFO" with "LOG":**
   ```bash
   sed 's/INFO/LOG/g' sam.log
   ```

#### Line Numbers
- **Find line numbers containing "INFO":**
   ```bash
   sed -n -e '/INFO/=' sam.log
   ```

- **Print matching lines along with their line numbers:**
   ```bash
   sed -n -e '/INFO/=' -e '/INFO/p' sam.log
   ```

#### Range Operations
- **Replace and print specific line ranges:**
   ```bash
   sed '1,20 s/INFO/VIGNAN---LOG/g; 1,10p; 11q' sam.log
   ```

---

## GREP

**GREP** is a command-line tool used to search for specific patterns of text within files or output. It scans each line of input, looks for matches to the specified pattern, and outputs those matching lines.

### Examples

#### Basic Usage
- **Search for "INFO" (case-insensitive):**
   ```bash
   grep -i INFO sam.log
   ```

- **Count occurrences of "INFO":**
   ```bash
   grep -ic INFO sam.log
   ```

#### Combining with Other Tools
- **Count occurrences of "INFO" using AWK:**
   ```bash
   awk '/INFO/ {count++} END {print count}' sam.log
   ```

- **Search for a process:**
   ```bash
   ps aux | grep ubuntu
   ```

---

## Miscellaneous

- **Extract specific fields from a script:**
   ```bash
   awk '/awk/ {for(i=2; i<=10; i++) print $i}' awk_sed_grep.sh
   ```

- **Filter Ansible configuration version:**
   ```bash
   ansible --version | grep config | awk '{print $2}'
   ```

---

This guide provides a quick reference for using AWK, SED, and GREP effectively in text processing tasks.

