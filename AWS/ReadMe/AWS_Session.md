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
