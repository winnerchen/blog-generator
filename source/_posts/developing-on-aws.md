---
title: Developing On AWS
date: 2019-11-25 16:20:55
tags:
---

## Course Structure
### Fundamentals for 3-tier web apps

* Cloud Compute
	* IAM
	* EC2
	* ELB
	*	ROUTE 53

- Data Store
	* RDS
	* ElastiCache

- Object Storage
	* S3

<!--more-->

### Developer tools
- AWS CLI
- Python SDK 
- Node.js
- IAM



### CI/CD with monitoring and infrastructure as code
- Elastic Beanstalk
- AWS CodeCommit
- CodeBuild
- CodeDeploy
- CodePipeline
- CloudFormation
- CloudWatch
- CloudTrail
- X-Ray

### Application decoupling & integration
- SQS
- SNS
- Kinesis

### Servless paradigm
- Lambda
- Dynamodb
- Dynamodb accelerator
- API Gateway
- Coginto
- SAM



## AWS fundamentals: IAM+EC2
### IAM
- users
	- usually a physical person
- Groups
	- Contains users
	- users in the group inherits permission attached to this group
- Roles
	- Internal usage within AWS resources
- Policies
	- define permissions

![image](https://developing-on-aws-imgs.s3-ap-southeast-2.amazonaws.com/1.jpg)

- IAM has global view
- Permissions are governed by Policies
- Least privilege principles

-
#### IAM 101
- One IAM User per physical person
- One IAM role per application
- IAM credentials should never be shared
- Never write IAM credentials in code
- Never use the root account except for initial setup
- Never use ROOT IAM credentials

#### Security Groups
- they control how traffic is allowed into or out of our EC2 machines
- Acts as a firewall on EC2 instances
- They regulate:
	- Access to Ports
	- authorised IP ranges - ipv4 and ipv6
	- control of inbound network
	- control of outbound network

	
##### Good to know about security groups
- can be attached to multiple instances
- one ec2 instance can attach to multiple security group
- locked down to a region/vpc combination 
- live outside of the ec2 - if traffice is blocked the ec2 instance won't see it
- it's good to maintain one separate security group for SSH access
- if your application is not accessible, then it's a security group issue
- if your application gives a 'connection refused' error, then it's an application error or it's not launched
- all inbound traffic is **blocked** by default
- all outbound traffice is **authorised** by default


![image](https://developing-on-aws-imgs.s3-ap-southeast-2.amazonaws.com/2.jpg)

a security group can reference to another security group and authorise instances that attach to the right security group to access

![image](https://developing-on-aws-imgs.s3-ap-southeast-2.amazonaws.com/3.jpg)

#### Private vs Public IP
- by default, your ec2 machine comes with
	- a private ip for the internal AWS network
	- a public ip, for the www
- when we are doing SSH into our EC2 machines
	- we can only use the public ip
- If your machine is stopped and restarted, the public IP can change


#### EC2 User Data
- Bootstrap script that allow you to run custom commands when a instance is launched
- It is only run once at the instance first started
- Used to automate boot tasks such as:
	- Installing updates
	- installing software
	- Downloading common files from the internet
	- Anything you can think of
- The ec2 user data scrip runs with the root privilege.

#### EC2 Instance Launce Types
- On Demand Instance: short work load, predictable pricing
	- pay for what you use
	- has the highest rate but no upfront payment
	- no long term commitment
- Reserved Instances: long workloads (>= 1 year)
	- up to 75% discount compared to on-demand
	- pay upfront for what you use with long term commitment
	- reservation period can be 1 or 3 years
	- reserve a specific instance type
	- recommended for steady state usage application (think of database)
- Convertible Reserved Instance: long workloads with flexible instances
	- can change the EC2 instance type
	- up to 54% discount
- Scheduled Reserved Instances: 
	- launch within time window you reserve
- Spot Instance: short workloads, for cheap, can lose instances
	- can get a discount of up to 90% compared to on-demand
	- you bid a price and get the instance as long as its under the price
	- price varies based on offer and demand
	- spot instances are reclaimed with a 2 minute notification warning when the spot price goes above your bid
	- used for batch jobs, Big Data analysis, or workloads that are resilient to failures
	- not great for critical services
- Dedicated Instances: no other customers will share your hardware
	- instances running on hardware that's dedicated to you
	- may share hardware with other instances in same account
	- no control over instance placement (can move hardware after stop/start)
- Dedicated Hosts: book an entire physical server, control instance placement
	- physical dedicated ec2 server for your use
	- full control of ec2 instance placement
	- visibility into the underlying sockets/physical cores of the hardware
	- allocated for your account for a 3 year period reservation
	- more expensive
	- useful for software that have complicated licensing model
	- or for companies that have strong regulatory or compliance needs

![image](https://developing-on-aws-imgs.s3-ap-southeast-2.amazonaws.com/4.jpg)

#### EC2 Pricing

- Pricing parameters (per hour):
	- region
	- Instance Type
	- Operating system

- billed by the second, with a minimum of 60 seconds.
- you do not pay for the instance if the instance is stopped

#### what is 

 