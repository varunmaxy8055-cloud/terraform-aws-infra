output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main_vpc.id
}

output "public_subnet_1" {
  description = "Public subnet 1"
  value       = aws_subnet.public_subnet_1.id
}

output "private_subnet_1" {
  description = "Private subnet 1"
  value       = aws_subnet.private_subnet_1.id
}

output "ec2_instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.app_server.id
}

output "s3_bucket_name" {
  description = "Private S3 bucket name"
  value       = aws_s3_bucket.private_bucket.bucket
}