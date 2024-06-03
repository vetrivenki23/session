# AWS Solution Architect Associate Training Session

## **Date: May 26, 2024**

#### 1. Generate Access and Secret Keys

#### 2. Set Up AWS CLI

#### 3. Enable MFA (Multi-Factor Authentication)

#### 4. Cost Manager - Establish a Zero Budget and Schedule Weekly Reports

#### 5. Launch an EC2 Instance via the Console

## **Date: June 2, 2024**

#### 6. IAM - Users, Group, Policy

#### 7. Private vs Public vs Elastic IP

#### 8. EC2 - AMI, Security Group, Key & UserDAta

#### 9. ENI (Elastic Network Interface)

#### 10. Hibernate in AWS EC2

## **Date: June 9, 2024**

#### 11. Regions , Availability Zones &  Edge Locations

<https://aws.amazon.com/about-aws/global-infrastructure/regions_az/?p=ngi&loc=2>

#### 11. CloudShell

#### 12. IAM - Role

#### 13. IAM - Security Tool - Credntial Report (account-level) & Access Advisor (user-level)

KT Seesion
43. EC2 Instance Purchasing Options
44. Spot Instances & Spot Fleet
45. EC2 Instances Launch Types Hands On

---

### AWS User

- **Entity**: Represents an individual person or application.
- **Credentials**: Unique username, password, and access keys.
- **Purpose**: Manages individual access to AWS resources.
- **Key Note**: Represents an individual with unique credentials for accessing AWS resources.

### AWS Group

- **Entity**: A collection of users.
- **Purpose**: Simplifies permission management for multiple users.
- **Usage**: Assign policies to groups to manage user permissions collectively.
- **Note**: Groups will only contain users, not other groups.
- **Key Note**: A collection of users that simplifies permission management by applying policies to multiple users at once.

### AWS Policy

- **Document**: Defines permissions for actions on AWS resources.
- **Types**: Managed policies (shared) and inline policies (specific).
- **Format**: Written in JSON, specifying allowed or denied actions.
- **Key Note**: A JSON document that defines permissions for actions on AWS resources, used to control access.

```markdown

This policy grants read-only access to all objects in the specified S3 bucket.

## Policy JSON

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "arn:aws:s3:::example-bucket",
        "arn:aws:s3:::example-bucket/*"
      ]
    }
  ]
}
```

## Elements Breakdown

- **Version**:
  - **Description**: Specifies the version of the policy language.
  - **Value**: `"2012-10-17"` (current version).

- **Statement**:
  - **Effect**:
    - **Description**: Defines whether the statement allows or denies the specified actions.
    - **Value**: `"Allow"` (permits the specified actions).

  - **Action**:
    - **Description**: Lists the actions that are allowed or denied.
    - **Values**:
      - `"s3:GetObject"`: Allows fetching objects from the bucket.
      - `"s3:ListBucket"`: Allows listing objects within the bucket.

  - **Resource**:
    - **Description**: Specifies the AWS resources to which the actions apply.
    - **Values**:
      - `"arn:aws:s3:::example-bucket"`: The S3 bucket itself.
      - `"arn:aws:s3:::example-bucket/*"`: All objects within the S3 bucket.

### AWS Role

- **Entity**: Defines permissions for making AWS requests.
- **Usage**: Intended for AWS services, applications, or external users.
- **Credentials**: Provides temporary security credentials when assumed.
- **Key Note**: An entity with a set of permissions for AWS services or external users, providing temporary credentials when assumed.

---

### Private vs Public vs Elastic IP

#### Private IP

- **Scope**: Used within private networks; not routable on the internet.
- **Usage**: Enables communication between devices in the same network.
- **Examples**: 192.168.x.x, 10.x.x.x, 172.16.x.x to 172.31.x.x.

#### Public IP

- **Scope**: Routable on the internet; used for communication outside the local network.
- **Usage**: Assigned to devices that need to be accessible over the internet, like web servers and email servers.
- **Examples**: 8.8.8.8 (Google DNS), 172.217.12.206 (Google).

#### Elastic IP

- **Scope**: A static public IP address provided by cloud service providers, notably AWS.
- **Usage**: Can be associated with and disassociated from instances dynamically; allows for consistent public IPs despite changing underlying resources.
- **Examples**: AWS Elastic IP (example format: 54.23.45.67).

### Key Differences

- **Private IP**: Not accessible over the internet, limited to local network communication.
- **Public IP**: Accessible over the internet, necessary for external communications.
- **Elastic IP**: A type of static public IP used in cloud environments, can be easily reassigned to different instances.

---

IP Range : <https://www.dan.me.uk/ipsubnets?ip=192.168.0.1>

---

### EC2 - AMI (Amazon Machine Image)

- **Definition**: A template that contains the software configuration (OS, application server, and applications) required to launch an EC2 instance.
- **Usage**: Used to create new instances with a pre-defined configuration.

### EC2 - Security Group

- **Definition**: A virtual firewall that controls the traffic to and from your EC2 instances.
- **Usage**: Defines rules for inbound and outbound traffic, enhancing security by specifying allowed IP ranges and ports.

### EC2 - Key Pair

- **Definition**: A set of security credentials (private key and public key) used to securely connect to an EC2 instance.
- **Usage**: The public key is stored on the instance, and the private key is kept by the user to establish SSH connections.

### EC2 - User Data

- **Definition**: A script or set of commands that is automatically executed when an EC2 instance is launched.
- **Usage**: Automates instance configuration tasks, such as installing software or setting environment variables during boot.

---

### EC2 - ENI (Elastic Network Interface)

- **Definition**: A virtual network interface that can be attached to an EC2 instance.
- **Usage**: Provides a flexible, low-cost way to manage network interfaces and IP addresses for EC2 instances. It can include multiple IP addresses, security groups, and a MAC address.

---

### Hibernate in AWS EC2

- **Definition**: Allows you to pause and resume EC2 instances by saving the instance's state (RAM) to disk.
- **Usage**: Save in-memory state to the root EBS volume when stopped and restore it when started.

**Key Points**:

- **Supported Instances**: Specific instance types (e.g., C3, C4, M3, M4, R3, R4).
- **Root Volume**: Must be an encrypted EBS volume.
- **OS**: Supported on certain OS versions (e.g., Amazon Linux, Ubuntu).

**Benefits**:

- **Fast Startup**: Faster resume compared to reboot.
