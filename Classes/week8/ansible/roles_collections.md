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

## Using `ansible-doc`

The `ansible-doc` command provides documentation for Ansible modules, plugins, and other components directly from the command line. It is useful for quickly referencing usage, options, and examples.

**Basic usage:**
```bash
ansible-doc --help
ansible-doc -h
```

This displays the help message, listing all available options and usage instructions.


## Useful Ansible Commands

To view documentation for the `copy` module (a core Ansible module):

```bash
ansible-doc -t module copy
```

To list all available Ansible become plugins and their short descriptions:

```bash
ansible-doc -t become -l
ansible-doc -t connections -l
```

These commands help users discover module usage details and available privilege escalation (become) plugins in their Ansible environment.

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

## Searching for Cloud Collections

To find available Ansible collections for working with cloud providers such as Amazon AWS or Microsoft Azure, you can use the `ansible-galaxy` command or search documentation. For example, to list collections related to Amazon or Azure:

```bash
ansible-galaxy collection list | grep amazon
ansible-galaxy collection list | grep azure
```

Alternatively, to search for modules and plugins related to these clouds, use `ansible-doc`:

```bash
ansible-doc -l | grep amazon
ansible-doc -l | grep azure
```

These commands help you discover modules and collections for managing cloud resources. For more details, refer to the README or documentation of each collection, such as [`amazon.aws`](https://galaxy.ansible.com/amazon/aws) or [`azure.azcollection`](https://galaxy.ansible.com/azure/azcollection).


## Installing an Ansible Collection

To install an Ansible collection from Ansible Galaxy, use the `ansible-galaxy collection install` command. This downloads and installs the specified collection into your Ansible environment.

**Example:**
```bash
ansible-galaxy collection install amazon.aws
```

You can also specify a version:
```bash
ansible-galaxy collection install amazon.aws:1.5.0
```

**![Image](https://github.com/user-attachments/assets/3e9ca2c5-f423-4b19-b7e8-c98dd19d8473)**


## Installing Azure Collections in a Specific Project Directory

To install the Azure collection into a specific project directory (instead of the global environment), use the `-p` or `--collections-path` option with `ansible-galaxy collection install`. This helps keep your project dependencies isolated.

**Example:**
```bash
ansible-galaxy collection install azure.azcollection -p ./project1/collections
ansible-galaxy collection install amazon.aws -p ./project1/collections

```
**![Image](https://github.com/user-attachments/assets/ac1ab1c3-1c8b-4388-839b-26d4a35301b3)**

This command installs the `azure.azcollection` collection into the `./project1/collections` directory. Update your `ansible.cfg` to include this path:

**ansible.cfg**
```ini
[defaults]
collections_paths = ./project1/collections
```

This configuration ensures Ansible loads collections from your project-specific directory.

To list all installed collections related to Azure, you can use:

```bash
ansible-galaxy collection list
ansible-galaxy collection list | grep azu
```
**![Image](https://github.com/user-attachments/assets/6910ed1f-8a9f-4528-9692-6493afc035cf)**

## Python Dependencies for Cloud Modules

When working with Amazon AWS or Microsoft Azure modules in Ansible, you often need to install additional Python libraries to enable API communication.

### For Amazon AWS

Many AWS modules require the `boto` and `boto3` libraries, as well as `botocore`. Install them using pip:

```bash
pip3 install boto boto3 botocore
```

### For Microsoft Azure

Azure modules typically require the `azure` Python SDK packages. The recommended way is:

```bash
pip install 'ansible[azure]'
```

Or, for more granular control:

```bash
pip install azure-cli
pip install azure-mgmt-resource
```

> **Note:** Always check the documentation for the specific collection or module you are using, as requirements may change.



To install collections listed in a `requirements.yml` file (commonly found in a collection's `README.md`):

**requirements.yml**
```yaml
collections:
    - name: amazon.aws
        version: ">=1.5.0"
    - name: azure.azcollection
```

**Install all requirements:**
```bash
ansible-galaxy collection install -r requirements.yml
```

For more details, refer to the [Ansible Galaxy documentation](https://docs.ansible.com/ansible/latest/collections_guide/collections_installing.html).




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