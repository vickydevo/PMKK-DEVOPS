# Ansible Modules and Plugins

## What are Modules?

**Modules** are the units of work in Ansible. Each module performs a specific task, such as installing packages, copying files, managing services, or interacting with cloud providers. Modules are called by playbooks or ad-hoc commands and return results to Ansible.

**Key points:**
- Perform discrete automation tasks
- Written in Python, PowerShell, or other languages
- Hundreds of built-in modules available

**Example usage:**
```yaml
- name: Install nginx
    ansible.builtin.yum:
        name: nginx
        state: present
```

## What are Plugins?

**Plugins** extend Ansible’s core functionality. They allow customization and enhancement of how Ansible executes tasks, processes data, logs output, and interacts with systems.

**Types of plugins:**
- **Callback plugins:** Customize output and logging
- **Connection plugins:** Define how Ansible connects to hosts
- **Lookup plugins:** Fetch data from external sources
- **Filter plugins:** Transform data in templates
- **Inventory plugins:** Define dynamic inventories

# Lists all available Ansible become plugins and their short descriptions.
#
# Syntax:
#   ansible-doc -t become -l

#
# This command helps users discover which privilege escalation methods (become plugins) are available for use in their Ansible environment.

**Example:**
A filter plugin can be used in a Jinja2 template:
```yaml
{{ my_var | to_nice_json }}
```

## Summary

- **Modules:** The building blocks that perform tasks in Ansible.
- **Plugins:** Extend and customize Ansible’s behavior and capabilities.


# Ansible Roles and Collections

## What are Roles?

**Roles** are a way to organize Ansible playbooks and tasks into reusable components. A role groups together tasks, variables, files, templates, and handlers that are related to a specific functionality (e.g., installing a web server). Roles help make playbooks cleaner, more modular, and easier to maintain.

**Key features:**
- Encapsulate automation logic
- Promote reuse and sharing
- Directory structure enforces best practices

**Example structure:**
```
roles/
    webserver/
        tasks/
        handlers/
        templates/
        files/
        vars/
        defaults/
        meta/
```

## What are Collections?

**Collections** are a distribution format for Ansible content. A collection can include roles, modules, plugins, playbooks, and documentation, bundled together for easy sharing and reuse. Collections are published and installed via Ansible Galaxy or Automation Hub.

**Key features:**
- Package multiple roles, modules, and plugins together
- Versioned and distributable
- Simplifies dependency management

**Example structure:**
```
my_namespace/
    my_collection/
        roles/
        plugins/
        playbooks/
        docs/
        galaxy.yml
```

## Summary

- **Roles**: Organize and reuse automation code within a project.
- **Collections**: Package and distribute roles, modules, and plugins for broader sharing.

For more details, see the [Ansible documentation](https://docs.ansible.com/ansible/latest/user_guide/collections_using.html).