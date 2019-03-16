from abc import ABC, abstractmethod
from typing import Generic, TypeVar, Optional
from managers import BaseManager as man
from flask import render_template, jsonify, request, make_response

T = TypeVar('T')
MANAGER = TypeVar('MANAGER', bound=man.BaseManager)


# noinspection PyMethodMayBeStatic
class BaseAPI(ABC, Generic[MANAGER, T]):
    def __init__(self):
        pass

    def create_response(self, response):
        actual_response = make_response(jsonify(response))
        actual_response.headers['Access-Control-Allow-Origin'] = '*'
        actual_response.headers['Access-Control-Allow-Credentials'] = True
        return actual_response

    def create_error_response(self, error):
        return jsonify({"status": "error", "error": str(error)})

    @property
    @abstractmethod
    def manager(self) -> MANAGER:
        raise Exception("You have not implemented this method")