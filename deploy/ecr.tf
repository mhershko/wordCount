resource "aws_ecr_repository" "python_app" {
  name = "${var.app_name}"
	force_delete = "true"
}

resource "null_resource" "docker_packaging" {

	  provisioner "local-exec" {
	    command = <<EOF
		cd ..
	    aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.eu-central-1.amazonaws.com
	    docker buildx build -t "${aws_ecr_repository.python_app.repository_url}:latest" --platform=linux/amd64 -f Dockerfile .
	    docker push "${aws_ecr_repository.python_app.repository_url}:latest"
		cd deploy
	    EOF
	  }


	  triggers = {
	    "run_at" = timestamp()
	  }


	  depends_on = [
	    aws_ecr_repository.python_app,
	  ]
}