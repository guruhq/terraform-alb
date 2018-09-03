# terraform-alb 

A Terraform module to create an Amazon Web Services (AWS) Application Load Balancer (ALB)

## Usage

```hcl
module "application_loadbalancer" {
  source             = "git::https://github.com/guruhq/terraform-alb?ref=2.0.2"
  cluster_name       = "${var.cluster_name}"
  vpc_id             = "${var.vpc_id}"

  health_check_path  = "${var.health_check_path}"
  hc_matchers        = "${var.hc_matchers}"
  port               = "${var.port}"
  lb_port            = "${var.lb_port}"
  task_definition    = "${var.task_definition}"
  project            = "${var.project}"
  public_subnet_ids  = "${var.public_subnet_ids}"
  lb_internal_bool   = "${var.lb_internal_bool}"
  lb_security_groups = "${var.lb_security_groups}"

  deregistration_delay = "${var.deregistration_delay}"

  target_type        = "${var.target_type}"

  environment        = "${var.environment}"
  region             = "${var.region}"
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
- `health_check_path` - the path for the ELB to check health (Default: `unknown`)
- `port` - which port for the LB to hit the service (Default: `unknown`)
- `lb_port` - the port the LB will serve traffic  (Default: `80`)
- `deregistration_delay` - time it will take to remove old deployments (Default `300`)
- `healthy_threshold` - how many intervals to assign health
- `unhealthy_threshold` - how many intervals to assign unhealthy
- `interval` - interval between checks in seconds
- `timeout` - amount of time in seconds before a timeout

## Outputs

- `target_group_arn` - The target group's ARN - for use with services that need access to the TG
- `lb_dns_name` - The FQDN of the ALB that spins up
- `zone_id` - the DNS Zone ID of the ALB
