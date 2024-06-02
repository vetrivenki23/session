# AWS Solution Architect Associate Training Session

## **Date: May 26, 2024**

#### 1. Generate Access and Secret Keys

#### 2. Set Up AWS CLI

#### 3. Enable MFA (Multi-Factor Authentication)

#### 4. Cost Manager - Establish a Zero Budget and Schedule Weekly Reports

#### 5. Launch an EC2 Instance via the Console

## **Date: June 2, 2024**

#### 6. IAM - Users, Group, Policy & Role

#### 7. Set Up AWS CLI

#### 8. Enable MFA (Multi-Factor Authentication)

#### 9. Cost Manager - Establish a Zero Budget and Schedule Weekly Reports

#### 10. Launch an EC2 Instance via the Console

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
