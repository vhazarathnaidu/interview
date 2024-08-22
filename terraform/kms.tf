#Create a KMS Key
resource "aws_kms_key" "key_name" {
  description = "KMS key for encrypting secrets in Secrets Manager"
  
  tags = {
    Name = "key_name-key"
  }
}

#Create a KMS Key Policy
resource "aws_kms_key_policy" "key_name" {
  key_id = aws_kms_key.example.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          AWS = "*"
        },
        Action = [
          "kms:Decrypt",
          "kms:Encrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*"
        ],
        Resource = "*"
      },
    ],
  })
}


#Create a Secret in AWS Secrets Manager
resource "aws_secretsmanager_secret" "secrect_name" {
  name        = "secrect_name_example"
  description = "This secret is encrypted with a custom KMS key."
  
  # Optionally, you can specify a KMS key to use for encryption
  kms_key_id = aws_kms_key.secrect_name.id
}

#Add Secret Value to the Secret

resource "aws_secretsmanager_secret_version" "secrect_key_name" {
  secret_id     = aws_secretsmanager_secret.secrect_key_name.id
  secret_string = jsonencode({
    username = "admin"
    password = "P@ssw0rd"
  })
}
