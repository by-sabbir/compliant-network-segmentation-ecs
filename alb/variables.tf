variable "load_balancer_sg" {
  type = string
  default = "sg-0e47e4174e52697e5"
}

variable "public_subnet_lb" {
  type = list(string)
  default =[
    "subnet-03c829c7de8681d9b",
    "subnet-0035839d8f0490ac7",
    "subnet-0c1f20cdc12bae4e6",
  ]

}

variable "bucket" {
  type = string
  default = "tfstate-stored"
}

variable "vpc_id" {
  type = string
  default = "vpc-0e21d6695eb9c8b7a"
}