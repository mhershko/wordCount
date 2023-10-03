
from flask import (
    Flask
)


def create_app():
    app = Flask(__name__, instance_relative_config=False)
    app.config.from_object('config.Config')

    with app.app_context():
        from views import web
        app.register_blueprint(web)

    return app
