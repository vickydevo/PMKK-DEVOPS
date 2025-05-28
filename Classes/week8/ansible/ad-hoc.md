# Ad-hoc Commands in Ansible

Ad-hoc commands are simple one-line commands used to perform quick tasks on managed hosts without writing a playbook.

## Examples

### 1. Using the `ansible.builtin.file` Module
The `file` module is useful for:

- Creating or deleting files, directories, or symbolic links on managed nodes.
- Retrieving existing file details such as mode, owner, group, and size.
- Modifying file parameters like mode, owner, group, and access/modified times.

Create a directory:
```bash
ansible all -m ansible.builtin.file -a "path=/tmp/demo_dir state=directory"

ansible ubuntu -m ansible.builtin.file -a "path=./app1/demo.txt state=touch mode=0744"
```

### 2. Using the `ansible.builtin.lineinfile` Module
Add a line to a file:
```bash
ansible all -m ansible.builtin.lineinfile -a "path=/etc/example.conf line='my_setting=yes'"
```

### 3. Using the `ansible.builtin.copy` Module
Copy a file to remote hosts:
```bash
ansible all -m ansible.builtin.copy -a "src=./localfile.txt dest=/tmp/remotefile.txt"
```

### 4. Using the `ansible.builtin.fetch` Module
Fetch a file from remote hosts:
```bash
ansible all -m ansible.builtin.fetch -a "src=/etc/hosts dest=./hosts_backup/"
```

### 5. Using the `ansible.builtin.debug` Module
Display a message:
```bash
ansible all -m ansible.builtin.debug -a "msg='Hello from Ansible!'"
```