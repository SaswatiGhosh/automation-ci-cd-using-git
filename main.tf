terraform {
  backend "s3" {
    bucket = "my-bucket-terraform-state-99"
    key    = "s3_git_hub_action/terraform.tfstate"
    region = "ap-south-1"
    encrypt = true

  }
  required_version = ">=0.13.0"
  required_providers{
    aws = {
        source  = "hashicorp/aws"
        version = "4.31.0"
}
}
}


provider "aws" {
    region = "ap-south-1"
    
  
}
# resource "aws_s3_bucket" "example" {
#     bucket = "example-bucket-9999999999999999999"
  
# }
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "function.py"
  output_path = "lambda_function_payload.zip"
}

resource "aws_lambda_function" "test_lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = data.archive_file.lambda.output_path
  function_name = "lambda_function_name"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "lambda_handler"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.9"

}