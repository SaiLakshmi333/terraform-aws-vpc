resource "aws_vpc" "main"{
    cidr_block=var.vpc_cidr
    instance_tenancy="default"
    tags=local.vpc_final_tags
    enable_dns_hostnames = true
}

resource "aws_internet_gateway" "main"{
    vpc_id=aws_vpc.main.id
    tags=local.igw_final_tags
}

resource "aws_subnet" "main"{
    vpc_id=aws_vpc.main.id
    count=length(var.public_subnet_cidrs)
    cidr_block=var.public_subnet_cidrs[count.index]
    availability_zone = local.az_names
    map_public_ip_on_launch = true
     tags = merge(
        local.common_tags,
        # roboshop-dev-public-us-east-1a
        {
            Name = "${var.project}-${var.environment}-public-${local.az_names[count.index]}"
        },
        var.public_subnet_tags
    )
    }


