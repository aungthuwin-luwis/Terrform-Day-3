# Create VPC 
# Create IGW
# internet gateway to VPC
# Create SubNet
# Create RTB

data "aws_availability_zones" "available" {
  state = "available"
}


resource "aws_vpc" "My_Lab_VPC" {
    cidr_block = var.my_vpc_cidr
    tags = {
      Name = var.name_vpc
    }
  
}

resource "aws_internet_gateway" "My_Lab_IGW" {
    tags = {
      Name = "My_Lab_IGW"
    }
  
}

resource "aws_internet_gateway_attachment" "My_GW_attach" {
  vpc_id = aws_vpc.My_Lab_VPC.id
  internet_gateway_id = aws_internet_gateway.My_Lab_IGW.id
}


resource "aws_route_table" "My_Lab_RTB" {
  vpc_id = aws_vpc.My_Lab_VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.My_Lab_IGW.id
  }
  tags = {
    Name = "My_Lab_RTB"
  }

}

resource "aws_subnet" "My_Lab_Sub01" {
    count = length(data.aws_availability_zones.available.names)
    vpc_id = aws_vpc.My_Lab_VPC.id
    availability_zone = var.zone_for_subnet[count.index]
    cidr_block = var.cidr_for_subnet[count.index]
    tags = {
      Name = var.name_for_subnet[count.index]
    }
      
}

resource "aws_route_table_association" "My_pub_rtb" {
    count = length(aws_subnet.My_Lab_Sub01)
  route_table_id = aws_route_table.My_Lab_RTB.id
  subnet_id = aws_subnet.My_Lab_Sub01[count.index].id

}
  
