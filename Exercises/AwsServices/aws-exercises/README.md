# AWS Services - EC2 Deployment Exercises

This repo walks through the process of deploying a Node.js application on an AWS EC2 instance using 
AWS CLI and automating it via Jenkins. Each step builds on the previous one, giving you practical, 
production-ready experience.

---

## 🧭 Project Goal

Your company has standardized on **AWS** to reduce multi-cloud overhead. You'll provision infrastructure,
 configure secure access, and deploy a Dockerized Node.js app via Jenkins automation.

---

## 📘 Exercises

### ✅ Exercise 1: Create IAM User

- Create a new IAM user (e.g., your name) and assign to group `devops`
- Grant the group permissions for:
  - VPC creation
  - EC2 provisioning
  - CLI access
- Use the AWS Console and an existing Admin user

---

### ✅ Exercise 2: Configure AWS CLI

- Use `aws configure` to set up access with the newly created IAM user
  - Access key and secret
  - Default region (e.g., `us-east-1`)
  - Output format (`json`, `text`, or `table`)

---

### ✅ Exercise 3: Create VPC and Security Group (via CLI)

- Create a custom VPC with one subnet
- Create a Security Group within the VPC that allows:
  - SSH access (`port 22`)
  - App/browser access (`port 8080` or your app’s port)

---

### ✅ Exercise 4: Launch EC2 Instance

- Provision an EC2 instance in your custom VPC
- Attach the previously created security group
- Use a `.pem` key file for SSH access

---

### ✅ Exercise 5: SSH into EC2 & Install Docker

- SSH into the instance using your key file:

---

### ✅ Exercise 6: Add Docker Compose for Deployment

To simplify and manage deployment of your Node.js application, you'll use Docker Compose.

---

### ✅ Exercise 7: Add "Deploy to EC2" Step to Your Jenkins Pipeline

To automate the deployment process of your Node.js app to your EC2 instance, you'll add a deployment 
stage to your existing Jenkins pipeline.

---

### ✅ Exercise 8: Configure Access from Browser (EC2 Security Group)

After your Jenkins pipeline deploys the application to EC2, the service may still be inaccessible 
from the browser. This is typically due to missing ingress rules on the EC2 security group.

---

### ✅ Exercise 9: Configure Automatic Triggering of Multibranch Pipeline

To improve CI/CD efficiency and avoid premature deployments, you’ll configure your Jenkins pipeline
to respond to branch activity appropriately and automatically.