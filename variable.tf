#Declare variable for VPC
variable "name_vpc" {
    default = "My_Lab_VPC"
  
}

#Declare variable for VPC_CIDR
variable "my_vpc_cidr" {
  default = "10.0.0.0/16"
}

#Declare variable Zone for Subnet
variable "zone_for_subnet" {
  type = list(string)
  default = [ "ap-southeast-1a" , "ap-southeast-1b" ,"ap-southeast-1c"]
}

#Declare variable CIDR for subnet
variable "cidr_for_subnet" {
  type = list(string)
  default = [ "10.0.1.0/24" , "10.0.2.0/24" ,"10.0.3.0/24"]
}

#Declare variable name for subnet
variable "name_for_subnet" {
  type = list(string)
  default = [ "My_Lab_Sub01" , "My_Lab_Sub02" ,"My_Lab_Sub03"]
}
