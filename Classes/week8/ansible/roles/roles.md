# Roles in Ansible

Roles in Ansible provide a standardized way to automatically load related variables, files, templates, handlers, and tasks using a known directory structure. This organization simplifies the reuse and sharing of automation content.

## Benefits of Roles

- **Modularization:** Roles help in organizing playbooks by grouping related content.
- **Reusability:** Roles can be reused across different playbooks and projects.
- **Maintainability:** The structured approach makes it easier to maintain and update automation code.

## Creating a Role Directory Structure

To create the directory structure for a new role, use the following command:
```bash
ansible-galaxy init <role_name>


ansible-galaxy init httpd --offline

```


Replace `<role_name>` with the desired name for your role. This command will generate the standard directory structure for an Ansible role.