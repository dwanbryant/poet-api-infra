resource "aws_vpc" "fastapi_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "fastapi-vpc"
  }
}

resource "aws_internet_gateway" "fastapi_igw" {
  vpc_id = aws_vpc.fastapi_vpc.id
  tags = {
    Name = "fastapi-igw"
  }
}

resource "aws_subnet" "fastapi_public_subnet" {
  count             = 2
  vpc_id            = aws_vpc.fastapi_vpc.id
  cidr_block        = cidrsubnet(aws_vpc.fastapi_vpc.cidr_block, 8, count.index)
  availability_zone = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "fastapi-public-subnet-${count.index + 1}"
  }
}

resource "aws_route_table" "fastapi_public_rt" {
  vpc_id = aws_vpc.fastapi_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.fastapi_igw.id
  }
  tags = {
    Name = "fastapi-public-rt"
  }
}

resource "aws_route_table_association" "fastapi_public_rt_assoc" {
  count          = 2
  subnet_id      = element(aws_subnet.fastapi_public_subnet[*].id, count.index)
  route_table_id = aws_route_table.fastapi_public_rt.id
}
