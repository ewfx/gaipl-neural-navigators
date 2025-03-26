# EC2 Instance for FastAPI Backend
resource "aws_instance" "gira_backend" {
  ami             = "ami-0402e56c0a7afb78f"  # Amazon Linux 2 AMI
  instance_type   = var.instance_type
  key_name        = "new_pem"  # Replace with your key pair
  security_groups = [aws_security_group.gira_sg.name]
  iam_instance_profile = aws_iam_instance_profile.gira_ec2_profile.name  # IAM Role Attached

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras enable python3.8
              sudo yum install -y python3 pip git awslogs
              pip3 install fastapi uvicorn boto3 psycopg2 pymongo requests
              git clone https://github.com/your-repo/gira.git /home/ec2-user/gira
              cd /home/ec2-user/gira
              uvicorn main:app --host 0.0.0.0 --port 8000 --reload &

              # Configure CloudWatch Logs
              echo "[general]" > /etc/awslogs/awscli.conf
              echo "region = ap-south-1" >> /etc/awslogs/awscli.conf

              echo "[/var/log/gira.log]" > /etc/awslogs/awslogs.conf
              echo "log_group_name = gira-backend-logs" >> /etc/awslogs/awslogs.conf
              echo "log_stream_name = ec2-instance" >> /etc/awslogs/awslogs.conf
              echo "file = /var/log/gira.log" >> /etc/awslogs/awslogs.conf

              sudo systemctl start awslogsd
              EOF

  tags = { Name = "GIRA-Backend" }
}

# Security Group for EC2
resource "aws_security_group" "gira_sg" {
  name        = "gira-security-group"
  description = "Allow SSH and API traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# RDS Database
resource "aws_db_instance" "gira_db" {
  identifier           = "gira-db"
  engine              = "postgres"
  instance_class      = "db.t3.micro"
  allocated_storage   = 20
  db_name             = var.db_name
  username           = var.db_username
  password           = var.db_password
  publicly_accessible = true
  skip_final_snapshot = true
}

# S3 Bucket for Frontend Hosting
resource "aws_s3_bucket" "gira_frontend" { bucket = "gira-frontend-bucket" }

# SNS Topic for Alerts
resource "aws_sns_topic" "gira_alerts" { name = "gira-critical-alerts" }

# IAM Role for EC2
resource "aws_iam_role" "gira_ec2_role" {
  name = "gira-ec2-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{ Effect = "Allow", Principal = { Service = "ec2.amazonaws.com" }, Action = "sts:AssumeRole" }]
  })
}

resource "aws_iam_policy" "gira_policy" {
  name        = "gira-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      { Effect = "Allow", Action = ["s3:*"], Resource = "arn:aws:s3:::gira-frontend-bucket/*" },
      { Effect = "Allow", Action = ["logs:*"], Resource = "*" }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "gira_role_attach" {
  role       = aws_iam_role.gira_ec2_role.name
  policy_arn = aws_iam_policy.gira_policy.arn
}

resource "aws_iam_instance_profile" "gira_ec2_profile" {
  name = "gira-ec2-profile"
  role = aws_iam_role.gira_ec2_role.name
}











