#Create new IAM Policy
# Attach Policy to an IAM Role
# Attach Policy to an IAM User

resource "aws_iam_policy" "s3_read_only_policy" {
  name        = "S3ReadOnlyPolicy"
  description = "IAM policy for read-only access to a specific S3 bucket"

  # Define the policy document
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::your-bucket-name",                 # The bucket itself
          "arn:aws:s3:::your-bucket-name/*"                # Objects within the bucket
        ]
      }
    ]
  })
}

# Attach Policy to an IAM Role
resource "aws_iam_role" "example_role" {
  name = "ExampleRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "example_role_policy_attachment" {
  role       = aws_iam_role.example_role.name
  policy_arn  = aws_iam_policy.s3_read_only_policy.arn
}


#Attach Policy to an IAM User

resource "aws_iam_user" "example_user" {
  name = "example_user"
}

resource "aws_iam_user_policy_attachment" "example_user_policy_attachment" {
  user       = aws_iam_user.example_user.name
  policy_arn  = aws_iam_policy.s3_read_only_policy.arn
}
