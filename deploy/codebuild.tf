resource "aws_codebuild_project" "python_app" {
  name          = "python_app"
  description   = "Python AWS Words Count App"
  build_timeout = "5"
  service_role  = aws_iam_role.python_app_codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true

    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = var.default_region
    }

    environment_variable {
      name  = "DOCKER_USERNAME"
      value = var.docker_username
    }

    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = data.aws_caller_identity.current.account_id
    }

    environment_variable {
      name  = "IMAGE_NAME"
      value = var.app_name
    }

    environment_variable {
      name  = "CONTAINER_NAME"
      value = var.app_name
    }

    environment_variable {
      name  = "ECR_REPO_URL"
      value = aws_ecr_repository.python_app.repository_url
    }
  }

  source {
    type = "CODEPIPELINE"
  }
}
