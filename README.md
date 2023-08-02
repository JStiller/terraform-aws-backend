# Terraform Backend on AWS

This is a Terraform module that creates a backend on AWS.

## Usage

To use this module, include something like the following in your Terraform code:

```hcl
module "backend" {
  region         = "eu-central-1"
  key            = "terraform-state"
  bucket_name    = "state-bucket"
  dynamodb_table = "state-lock-table"
  encrypt        = true
}
```

## Inputs

The following input variables are supported:

- `key` (required): The name of the state file.
- `region` (required): The AWS region to use.
- `bucket_name` (required): The name of the S3 bucket to use for storing Terraform state.
- `dynamodb_table` (required): The name of the DynamoDB table to use for locking Terraform state.

## Outputs

The following output variables are available:

- `s3_bucket_arn`: The ARN of the S3 bucket used for storing Terraform state.
- `dynamodb_table_arn`: The ARN of the DynamoDB table used for locking Terraform state.

## License

This code is released under the MIT License. See [LICENSE](LICENSE) for more information.

## Additional Resources

Please make use of the wonderful instructions of [Zevgeniz Brikman](https://blog.gruntwork.io/how-to-manage-terraform-state-28f5697e68fa). Author of [Terraform: Up & Running](http://www.terraformupandrunning.com/).

- [Terraform documentation](https://www.terraform.io/docs/index.html)
- [Terraform AWS Provider documentation](https://www.terraform.io/docs/providers/aws/index.html)
