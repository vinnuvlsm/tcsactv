*** Settings ***
Library   RequestsLibrary
Library   Collections
Library   JSONLibrary
Library    jsonvalidator.py

*** Variables ***
${url}    https://gorest.co.in/
${uri}    public/v1/users?access-token=xxx&fbclid=IwAR2GkqnCBvQeai-QEojlpnO-6PGcXiZ_maJLHHBWuOM8PDegliPM5YJdQHk

*** Test Cases ***
VerifyRestServiceWithoutAuth
    create session   api_demo   ${url}  verify=True
    ${res}=    get on session   api_demo   public/v1/users
    log to console  ${res.status_code}
    #verify http response codes
    Should Be Equal     ${res.status_code}    ${200}

VerifyNon-sslRestEndpoint
    create session   api_demo   http://gorest.co.in/  verify=True
    ${res}=    get on session   api_demo   public/v1/users
    log to console  ${res.status_code}
    #verify http response codes
    Should Be Equal     ${res.status_code}    ${200}

VerifyHttpResponseCodes
    create session   api_demo   ${url}  verify=True
    ${res}=    get on session   api_demo   ${uri}
    log to console  ${res.status_code}
    #verify http response codes
    Should Be Equal     ${res.status_code}    ${200}
    ${jsonRes}    set variable    ${res.json()}
    log to console    ${res.json()}

VerifyPageHasValidJsonData
    #Verify page has valid json data
    ${res}=    get on session   api_demo   ${uri}
    ${jsonRes}    set variable    ${res.json()}
    ${json_formt}    json_validator    ${jsonRes}
    Should Be Equal    ${json_formt}    ${True}

VerifyPageHasPagination
    # verify response has pagination
    ${res}=    get on session   api_demo   ${uri}
    ${jsonRes}    set variable    ${res.json()}
    ${json_key}    Get Dictionary Keys    ${jsonRes["meta"]}
    log to console   ${json_key}
    log to console    ${jsonRes["data"]}
    Should Be Equal    ${json_key}[0]    pagination

VerifyResponseDataHasEmailAddress
    ${res}=    get on session   api_demo   ${uri}
    ${jsonRes}    set variable    ${res.json()}
    #verify response data has email address
    FOR   ${data_values}   IN    @{jsonRes["data"]}
        log to console    ${data_values['email']}
        ${valid_email}    checkvalidEmail    ${data_values['email']}
        Should Be Equal    ${valid_email}    ${True}
    END

VerifyJsonSimilarAttributes
    ${res}=    get on session   api_demo   ${uri}
    ${jsonRes}    set variable    ${res.json()}
    #verify all entries on list data have similar attribute
    FOR   ${data_values}   IN    @{jsonRes["data"]}
        verifyjsonSchemaValidation    ${data_values}
    END