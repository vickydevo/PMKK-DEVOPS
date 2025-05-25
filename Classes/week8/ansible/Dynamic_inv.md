# Dynamic Inventory with Ansible and AWS EC2

## Step 1: Install AWS Collection

```bash
ansible-galaxy collection install amazon.aws
```

## Step 2: Get Access Keys for AWS Account

- Obtain your AWS Access Key ID and Secret Access Key from the AWS IAM console.
- Configure them using `aws configure` or set as environment variables:
    ```bash
    export AWS_ACCESS_KEY_ID=your_access_key
    export AWS_SECRET_ACCESS_KEY=your_secret_key
    export AWS_DEFAULT_REGION=your_region
    ```

## Step 3: Create Inventory File

- Create a file named `aws_ec2.yml` (or `myproject.aws_ec2.yml`).

## Step 4: Write Logic in Inventory File

Example `aws_ec2.yml` using the `aws_ec2` inventory plugin:


To list available inventory plugins and filter for AWS-related ones, use:

```bash
ansible-doc -t inventory -l | grep aws
```

This will show plugins like `amazon.aws.aws_ec2` that can be used for dynamic inventory with AWS.

```yaml
plugin: amazon.aws.aws_ec2
regions:
    - us-east-1
filters:
    tag:Name: ansadmin
keyed_groups:
    - key: tags.Name
        prefix: tag
hostnames:
    - private-ip-address
```

- Adjust `regions` and `filters` as needed for your environment.
- This example filters instances with the tag `Name=ansadmin`.

## Note

- Typically, new servers are launched from a custom AMI where the `ansadmin` user is already configured.
- Ensure your AMI includes the necessary user and SSH key setup for Ansible access.

## References

- [Ansible AWS EC2 Dynamic Inventory Plugin Documentation](https://docs.ansible.com/ansible/latest/collections/amazon/aws/aws_ec2_inventory.html)
- [Amazon AWS Collection for Ansible](https://galaxy.ansible.com/amazon/aws)