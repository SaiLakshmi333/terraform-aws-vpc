resource "aws-vpc" "main"{
    cidr_block=var.vpc_cidr
    instance_tenancy="default"
    tags=local.vpc_final_tags
}

