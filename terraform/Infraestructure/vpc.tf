resource "aws_vpc" "devops_project_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "devops-project-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.devops_project_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-north-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}