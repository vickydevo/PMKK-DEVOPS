## What is an Ansible Playbook?

An **Ansible playbook** is a YAML file that defines a series of tasks to automate configuration, deployment, and orchestration on remote systems. Playbooks are used to describe the desired state of your systems in a simple, human-readable format.

### Why Use Playbooks?

- **Automation:** Automate repetitive tasks and deployments.
- **Consistency:** Ensure the same configuration is applied across multiple servers.
- **Idempotency:** Tasks are only applied when needed, preventing unnecessary changes.
- **Documentation:** Playbooks serve as documentation for your infrastructure.

---

## Example Playbook: Install HTTPD on Amazon Linux and Apache2 on Ubuntu

```yaml
---
- name: Install web server based on OS
  hosts: all
  become: yes
  gather_facts: true  # <-- Needed to get ansible_os_family

  vars:
    redhat_family: "RedHat"
    debian_family: "Debian"

  tasks:
    - name: Display OS family variable
      debug:
        msg: "RedHat family: {{ redhat_family }}, Debian family: {{ debian_family }}"

    - name: Install httpd on RedHat-based systems
      ansible.builtin.yum:
        name: httpd
        state: present
      when: ansible_os_family == redhat_family

    - name: Install apache2 on Debian-based systems
      ansible.builtin.apt:
        name: apache2
        state: present
        update_cache: yes
      when: ansible_os_family == debian_family

```
```