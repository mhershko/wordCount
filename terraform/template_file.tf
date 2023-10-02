data "template_file" "task_definition_template" {
  template = file("task_definition.json.tpl")
  vars = {
    REPOSITORY_URL = var.flask_app_image
    FLASK_APP = var.flask_app
    FLASK_APP_HOME = var.flask_app_home
    FLASK_APP_PORT = var.flask_app_port
  }
}
