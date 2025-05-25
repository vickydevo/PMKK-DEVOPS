# Ansible Dynamic Inventory with AWS EC2

This guide explains how to set up and use Ansible's dynamic inventory with AWS EC2 instances.

## Prerequisites

- Ansible installed on your system
- AWS account with access keys
- AWS CLI installed (`pip3 install awscli --user`)

## 1. Install the AWS Collection

Install the Amazon AWS Ansible collection:

```bash
ansible-galaxy collection install amazon.aws
```

## 2. Configure AWS Credentials

You can provide AWS credentials in several ways:

### Option 1: Environment Variables

```bash
export AWS_ACCESS_KEY_ID=your_access_key
export AWS_SECRET_ACCESS_KEY=your_secret_key
export AWS_DEFAULT_REGION=your_region
```

### Option 2: AWS CLI Profile

Configure a dedicated profile:

```bash
aws configure --profile ansibleautomation
```

To use this profile with Ansible:

```bash
export AWS_PROFILE=ansibleautomation
```

Or specify the profile in your inventory file:

```yaml
profile: ansibleautomation
```

## 3. Create the Dynamic Inventory File

Create a file named `aws_ec2.yml` (or similar). Example content:

```yaml
---
plugin: amazon.aws.aws_ec2
regions:
    - us-east-1
    - us-east-2
leading_separator: False
keyed_groups:
    - key: tags.Env
        prefix: tag
filters:
    instance-state-name: running
```

- Adjust `regions` and `filters` as needed.
- Use `keyed_groups` to group hosts by tags (e.g., `tags.Env`).

**![Image](https://github.com/user-attachments/assets/6a87ebc0-45d5-4944-8f37-d5d81e15f7d1)**

## 4. List Available Inventory Plugins

To see available AWS inventory plugins:

```bash
ansible-doc -t inventory -l | grep aws
```

## 5. View Dynamic Inventory

Generate and view your dynamic inventory:

```bash
ansible-inventory -i aws_ec2.yml --list
ansible-inventory -i aws_ec2.yml --graph
```

This outputs discovered EC2 instances and their groupings.

## 6. Test Connectivity

To test connectivity to EC2 instances grouped by tag (e.g., `tag_dev`):

```bash
ansible tag_dev -m ansible.builtin.ping -i aws_ec2.yml
```

Ensure your EC2 instances have the appropriate tags and security group rules for SSH access.

## 7. Clear AWS Credentials (Optional)

To remove AWS credentials from your environment:

```bash
unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
unset AWS_SESSION_TOKEN
```

## References

- [Ansible AWS EC2 Dynamic Inventory Plugin Documentation](https://docs.ansible.com/ansible/latest/collections/amazon/aws/aws_ec2_inventory.html)
- [Amazon AWS Collection for Ansible](https://galaxy.ansible.com/amazon/aws)
