resource "aws_iam_user" "demouser1" {
  name = "project_tf_user1"
  path = "/"

  tags = {
    purpose = "hands-on"
  }
}