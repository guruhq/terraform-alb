# terraform-nlb 

A Terraform module to create an Amazon Web Services (AWS) Network Load Balancer (NLB)

## Usage

```hcl
module "application_loadbalancer" {
  source             = "git::ssh://git@github.com/guruhq/terraform-nlb?ref=1.0.0"
  port               = "${var.port}"
  vpc_id             = "${var.vpc_id}"
  task_definition    = "${var.task_definition}"
  project            = "${var.project}"
  public_subnet_ids  = "${var.public_subnets}"
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
- `vpc_id` - VPC to launch into (Default: `unknown`)
## Outputs

- `target_group_arn` - The target group's ARN - for use with services that need access to the TG
