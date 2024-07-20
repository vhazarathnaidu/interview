data "aws_secretsmanager_secret_version" "creds" {
    secret_id = "secret-name"
}

locals {
  db_creds = jsondecode(
    data.aws_secretsmanager_secret_version.creds.secret_string
  )
}

resource "aws_db_instance" "ntierdb" {
    allocated_storage = 20
    allow_major_version_upgrade = false
    auto_minor_version_upgrade = false
    backup_retention_period = 0
    engine = "mysql"
    engine_version = "8.0.20"
    instance_class = "db.t2.micro"


    username = local.db_creds.username
    password = local.db_creds.password


    tags = {
      "Name" = "ntierdb"
    }
    skip_final_snapshot  = true

    depends_on = [ 
        aws_db_subnet_group.dbsubnetgroup
     ]
  
}