import os

import click
from flask import (
    Flask, current_app
)
from flask.cli import with_appcontext


def create_app():
    app = Flask(__name__, instance_relative_config=False)
    app.config.from_object("config.Config")

    with app.app_context():
        from views import web
        app.register_blueprint(web)

    return app
