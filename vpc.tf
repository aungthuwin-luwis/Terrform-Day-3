# Create VPC 
# Create IGW
# internet gateway to VPC
# Create SubNet
# Create RTB

#data view (Zone state)
data "aws_availability_zones" "available" {
  state = "available"
}


#Create VPC
resource "aws_vpc" "My_Lab_VPC" {
    cidr_block = var.my_vpc_cidr
    tags = {
      Name = var.name_vpc
    }
  
}

#Create IGW
resource "aws_internet_gateway" "My_Lab_IGW" {
    tags = {
      Name = "My_Lab_IGW"
    }
  
}

#Create IGW Attach
resource "aws_internet_gateway_attachment" "My_GW_attach" {
  vpc_id = aws_vpc.My_Lab_VPC.id
  internet_gateway_id = aws_internet_gateway.My_Lab_IGW.id
}


#Create Route Table
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

#Create Subnet
resource "aws_subnet" "My_Lab_Sub01" {
    count = length(data.aws_availability_zones.available.names)
    vpc_id = aws_vpc.My_Lab_VPC.id
    availability_zone = var.zone_for_subnet[count.index]
    cidr_block = var.cidr_for_subnet[count.index]
    tags = {
      Name = var.name_for_subnet[count.index]
    }
      
}

#Create Route Table Association
resource "aws_route_table_association" "My_pub_rtb" {
    count = length(aws_subnet.My_Lab_Sub01)
  route_table_id = aws_route_table.My_Lab_RTB.id
  subnet_id = aws_subnet.My_Lab_Sub01[count.index].id

}
  
