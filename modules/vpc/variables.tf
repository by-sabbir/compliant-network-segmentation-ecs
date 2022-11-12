variable "allowed_cidr" {
  type = list(string)
  default = [ "0.0.0.0/0" ]
}

variable "cidr_block" {
  type = string
  default = "10.0.0.0/16"
}

variable "public_subnets_list" {
  type = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "db_subnets_list" {
  type = list(string)
  default = [ "10.0.201.0/24", "10.0.202.0/24", "10.0.203.0/24" ]

}