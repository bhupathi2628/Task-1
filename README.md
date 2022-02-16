# Task-1

1 Jenkins Instance
create N (configurable number) services with unique Tags for service on top of language of your choice - (source code can be identical) sample Java web app sample python web server
Services should be printing/returning the address of other services and redis instance
1 Elasticache Redis instance 
Use Terraform to provision the infra
Service should be built and deployed on the instances via Jenkins
Each deployment should create a new git tag based on build number post successful build 
Jenkins Script should make sure service is UP and echo status before exiting
Each service should have separate pipeline
The pipelines should be created via code


