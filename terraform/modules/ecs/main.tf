terraform {
  required_version = "~> 1.1.9"

  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "~> 4.14.0"
      configuration_aliases = [aws.us-east-1]
    }
  }
}
