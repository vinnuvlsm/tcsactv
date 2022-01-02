import json
import re

def json_validator(data):
    try:
        json.dumps(data)
        print("Valid Json")
        return True
    except ValueError as error:
        print("Invalid JSON: %s" % error)
        return False

regex = r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b'
