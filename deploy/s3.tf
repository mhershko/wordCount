resource "aws_s3_bucket" "python_app" {
  bucket        = "${var.app_name}-${var.environment}"
  force_destroy = true

}
