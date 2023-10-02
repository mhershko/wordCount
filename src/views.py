
from flask import (
    Blueprint,
    jsonify,
    request,
)
import logging

from auth_middleware import token_required
from word_count import WordCount

logger = logging.getLogger(__name__)

web = Blueprint('web', __name__, template_folder='templates')


@web.route('/', methods=['GET', 'POST'])
@token_required
def index():
    return jsonify({'status': 'success',
                    'message': 'call http://localhost:5000/count-words?fileName=<FILE NAME>'}
                   ), 200


# http://localhost:5000/count-words?fileName=<FILE NAME>
@web.route('/count-words')
@token_required
def count_words():
    file_name = request.args.get('fileName')
    res = WordCount().count_words_in_file(file_name)

    return res
