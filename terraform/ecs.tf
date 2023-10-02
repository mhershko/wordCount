# create the ECS cluster
resource "aws_ecs_cluster" "fp-ecs-cluster" {
  name = "words-count-app"

  tags = {
    Name = "words-count-app"
  }
}
