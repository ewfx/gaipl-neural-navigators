output "ec2_public_ip" { value = aws_instance.gira_backend.public_ip }
output "rds_endpoint" { value = aws_db_instance.gira_db.endpoint }
output "frontend_s3_url" { value = "http://${aws_s3_bucket.gira_frontend.bucket}.s3-website-us-east-1.amazonaws.com" }

