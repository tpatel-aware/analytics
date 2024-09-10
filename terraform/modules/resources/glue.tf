resource "aws_glue_catalog_database" "glue_database" {
  name = "glue_database"

  description = "Glue data catalog database"
  tags = {
    Name     = "Data catalog glue DB"
    resource = "Data catalog glue database"
  }
}
