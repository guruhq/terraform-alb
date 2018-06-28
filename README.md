# terraform-alb 

A Terraform module to create an Amazon Web Services (AWS) Application Load Balancer (ALB)

## Usage

```hcl
module "application_loadbalancer" {
  source             = "git::ssh://git@github.com/guruhq/terraform-nlb?ref=1.1.1"
  port               = "${var.port}"
  vpc_id             = "${var.vpc_id}"
  task_definition    = "${var.task_definition}"
  project            = "${var.project}"
  public_subnet_ids  = "${var.public_subnets}"
  target_type        = "${var.target_type}"
  lb_internal_bool   = true
}
```

## Variables
- `region` - Where it all happens (Default: `us-west-2`)
- `lb_internal_bool` - Boolean var to determain if the NLB should be public or private (Default: `true`)
- `project` - Name of the project or application (Default: `unknown`)
- `cluster_name` - Name of the cluster to launch into (Default: `unknown`)
- `task_definition` - Full task definition - taskdef:refNum (Default: `unknown`)
- `public_subnet_ids` - List of subnet ID's to launch ALB into - format ["subnet-xxxxxxxx", "subnet-xxxxxxxx"] (Default: `unknown`)
- `environment` - Service environment (Default: `unknown`)
- `target_type` - Allows you to choose between setting the target to be an instance or an IP
- `vpc_id` - VPC to launch into (Default: `unknown`)
- `hc_matchers` - a comma delimited list of usable return codes (Default: `200,404`)

## Outputs

- `target_group_arn` - The target group's ARN - for use with services that need access to the TG
- `lb_dns_name` - The FQDN of the ALB that spins up
- `zone_id` - the DNS Zone ID of the ALB
