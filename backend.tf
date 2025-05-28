# terraform {
#   backend "s3" {
#     bucket = "my-bucket-terraform-state-99"
#     key    = "s3_git_hub_action/terraform.tfstate"
#     region = "ap-south-1"
#     encrypt = true

#   }
#   required_version = ">=0.13.0"
#   required_providers{
#     aws = {
#         source  = "hashicorp/aws"
#         version = "4.31.0"
# }
# }
# }
