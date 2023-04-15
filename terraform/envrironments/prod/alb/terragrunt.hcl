# Terragrunt terraform
# https://terragrunt.gruntwork.io/docs/reference/config-blocks-and-attributes/#terraform

terraform {
  source = "../../..//modules/alb"
}

# Terragrunt include
# https://terragrunt.gruntwork.io/docs/reference/config-blocks-and-attributes/#include

include {
  path = find_in_parent_folders()
}

# Terragrunt dependency
# https://terragrunt.gruntwork.io/docs/reference/config-blocks-and-attributes/#dependency

dependency "acm" {
  config_path = "../acm"

  mock_outputs = {
    alb_acm_certificate_arn = "sg-1234567890abcdefg"
  }
}

# Terragrunt dependency
# https://terragrunt.gruntwork.io/docs/reference/config-blocks-and-attributes/#dependency

dependency "cognito" {
  config_path = "../cognito"

  mock_outputs = {
    cognito_user_pool_arn = "sg-1234567890abcdefg"
    cognito_user_pool_client_id = "sg-1234567890abcdefg"
    cognito_user_pool_domain_domain = "sg-1234567890abcdefg"
  }
}

# Terragrunt dependency
# https://terragrunt.gruntwork.io/docs/reference/config-blocks-and-attributes/#dependency

dependency "security_group" {
  config_path = "../security_group"

  mock_outputs = {
    alb_security_group_id = "sg-1234567890abcdefg"
  }
}

# Terragrunt dependency
# https://terragrunt.gruntwork.io/docs/reference/config-blocks-and-attributes/#dependency

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    public_subnet_ids = ["subnet-1234567890abcdefg"]
    vpc_id            = "vpc_1234567890abcdefg"
  }
}

# Terragrunt inputs
# @see https://terragrunt.gruntwork.io/docs/features/inputs/#inputs

inputs = {
  certificate_arn     = dependency.acm.outputs.alb_acm_certificate_arn
  user_pool_arn       = dependency.cognito.outputs.cognito_user_pool_arn
  user_pool_client_id = dependency.cognito.outputs.cognito_user_pool_client_id
  user_pool_domain    = dependency.cognito.outputs.cognito_user_pool_domain_domain
  security_groups     = [dependency.security_group.outputs.alb_security_group_id]
  subnets             = dependency.vpc.outputs.public_subnet_ids
  vpc_id              = dependency.vpc.outputs.vpc_id
}
