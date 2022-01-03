*** Settings ***

Library   RequestsLibrary
Library   Collections
Library   JSONLibrary
Library    jsonvalidator.py

*** Variables ***
${url}    https://gorest.co.in/
${uri}    public/v1/users?access-token=xxx&fbclid=IwAR2GkqnCBvQeai-QEojlpnO-6PGcXiZ_maJLHHBWuOM8PDegliPM5YJdQHk

*** Test Cases ***
Verify Rest service without auth
    create session   api_demo   ${url}  verify=True
    ${res}=    get on session   api_demo   public/v1/users
    log to console  ${res.status_code}
    #verify http responce codes
    Should Be Equal     ${res.status_code}    ${200}

Verify non-ssl rest endpoint
    create session   api_demo   http://gorest.co.in/  verify=True
    ${res}=    get on session   api_demo   public/v1/users
    log to console  ${res.status_code}
    #verify http responce codes
    Should Be Equal     ${res.status_code}    ${200}