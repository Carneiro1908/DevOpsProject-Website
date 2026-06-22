resource "aws_iam_role" "ec2_ecr_role" {
  name = "ec2-ecr-readonly-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"

      Principal = {
        Service = "ec2.amazonaws.com"
      }

      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecr_readonly" {
  role       = aws_iam_role.ec2_ecr_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-ecr-readonly-profile"
  role = aws_iam_role.ec2_ecr_role.name
}

resource "aws_iam_role" "ecr_full_access" {
  name = "github-actions-ecr-full-acsses"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Principal = {
        Federated = aws_iam_openid_connect_provider.github.arn
      }

      Action = "sts:AssumeRoleWithWebIdentity"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecr_full_access" {
  role       = aws_iam_role.ecr_full_access
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}