# 4640-w9-lab-start-w25

# Week 9 Lab: Packer & Terraform

## Prerequisites
- AWS account with CLI configured (`aws configure`)
- Terraform installed (`terraform --version`)
- Packer installed (`packer --version`)

## Steps

### 1. Import SSH Key
```sh
./import_lab_key
```

### 2. Build the Packer Image
```
cd packer
packer init .
packer validate .
packer build .
```
### 3. Deploy with Terraform
```
cd ../terraform
terraform init
terraform validate
terraform apply 
```
### 4. SSH into the EC2 Instance

terraform output public_ip
ssh -i ~/.ssh/your_key.pem ubuntu@<PUBLIC_IP>

### 5. (optional) Destory infrastructure
If you are no longer using the infrastructure use ```terraform destroy``` to clean up your environment.
