resource "aws_iam_user" "demouser1" {
  name = "project_tf_user1"
  path = "/"

  tags = {
    purpose = "hands-on"
  }
}

# 1. Allow EC2 instances to use an IAM role
resource "aws_iam_role" "tf_project1_ssm_role" {
  name = "tf_project1_ssm_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# 2. Give the role permission to communicate with Systems Manager
resource "aws_iam_role_policy_attachment" "ssm_core" {
  role       = aws_iam_role.tf_project1_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# 3. Make the role available to EC2 through an instance profile
resource "aws_iam_instance_profile" "tf_project1_ssm_profile" {
  name = "tf_project1_ssm_profile"
  role = aws_iam_role.tf_project1_ssm_role.name
}