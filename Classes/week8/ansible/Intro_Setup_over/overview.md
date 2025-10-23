# Deployment Example: With and Without Ansible

## Without Ansible (Manual Deployment)
```bash
#!/bin/bash
# Manual steps on each server
sudo yum update -y
sudo yum install python3 -y
mkdir basic-http-server
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
```

## With Ansible (Automated Deployment)
```yaml
# python-apache-playbook.yml
---
- name: Install Python and Apache
  hosts: web_servers
  become: yes
  tasks:
    - name: Update yum cache
      ansible.builtin.yum:        # <--- Indented relative to the 'name' above
        update_cache: yes    # <--- Indented 2 more spaces from 'ansible.builtin.yum'

    - name: Installing Python
      ansible.builtin.yum:
        name: python3
        state: present

    - name: Creates directory
      ansible.builtin.file:
        path: /basic-http-server
        state: directory

    - name: Install Apache
      ansible.builtin.yum:
        name: httpd
        state: present

    - name: Start and Enable Apache
      ansible.builtin.service:
        name: httpd
        state: started
        enabled: yes
```

### Running the Ansible Playbook
```bash
# Single command to deploy to all servers
ansible-playbook -i inventory python-httpd-playbook.yml
```

## Benefits of Using Ansible
- Automated deployment
- Consistent configuration
- Idempotent execution
- Version control for infrastructure
- Scalable to multiple servers
