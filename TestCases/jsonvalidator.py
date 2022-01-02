#   Lib Name: jsonvalidator.py
#   Purpose: to be used for Writing test cases to validate the REST API link
#   REST API Under Test: https://gorest.co.in/public/v1/users?access-token=xxx

# Test Cases To be covered:
#   Functional tests
#
#   Verify response has pagination
#   Verify response has Valid Json Data
#   Verify Response Data has email address
#   Verify all entries on list data have similar attributes.
#   Bonus – Any other tests you think is crucial to validate the API endpoint
#
#   Non Functional Tests
#
#   Verify HTTP response codes
#   Verify REST service without authentication
#   Verify Non-SSL Rest endpoint behaviour
#   Bonus - Any other non-functional test you think is critical.

import json
import re

# Function Name: json_validator
# Description: Accepts REST API response data from
# the URL and validates for proper json format using
# json.dumps function
# Return Value: True/False
def json_validator(data):
    try:
        json.dumps(data)
        print("Valid Json")
        return True
    except ValueError as error:
        print("Invalid JSON: %s" % error)
        return False

regex = r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b'

# Function Name: checkvalidEmail
# Description: Accepts data from
# the URL and validates for proper email-id format using
# the regular expression for valid email id.
# Return Value: True/False
def checkvalidEmail(email):
    # pass the regular expression
    # and the string into the fullmatch() method
    if (re.fullmatch(regex, email)):
        return True
    else:
        return False

def verifyjsonSchemaValidation(responce):
    schema = {
        "type": "object",
        "properties": {
            "id": {
                "type": "number"
            },
            "name": {
                "type": "string"
            },
            "email": {

                "type": "string"
            },
            "gender": {
                "type": "string"
            },
            "status": {
                "type": "string"
            }
        },
        "required": ["equipmentId", "lastUpdate", "state"]
    }