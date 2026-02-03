*** Settings ***
Library    RequestsLibrary
Library    Collections
Variables    ../environment.py
Variables    ../PageObjects/apivariables.py

Resource    ../resources/keywords.resource

Test Setup    Create Sessions

*** Variables ***
#${ID}          10
#${statusCode}    200
#${postStatusCode}    201


*** Test Cases ***
Get_Todo
    ${response}=    GET On Session    ${SESSION}   ${todos_endpoint}${ID}
    Log To Console    Status Code: ${response.status_code}
    #Log To Console    Response Body: ${response.text}
    #Log To Console    Headers: ${response.headers}

    Should be equal as integers     ${response.status_code}     ${statusCode}

    ${body}    convert to string    ${response.content}
    should contain    ${body}    true

Post_Todo
    ${body}=    Create Dictionary    userId=107    id=107    title=Robot    completed=True
    ${response}=    Post On Session    ${SESSION}    ${posts}    json=${body}

    Log To Console    Status Code : ${response.status_code}
    Log To Console    Response : ${response.json()}

    Should Be Equal As Integers    ${response.status_code}    ${postStatusCode}

Patch_Todo
    ${body}=    Create Dictionary    title=Updated Robot Title    completed=True
    ${response}=    Patch On Session    mysession    ${posts}/${ID}   json=${body}

    Log To Console    Status Code : ${response.status_code}
    Log To Console    Response : ${response.json()}

    Should Be Equal As Integers    ${response.status_code}    ${statusCode}

Update_Todo_PUT
    ${body}=    Create Dictionary
    ...    userId=1
    ...    id=1
    ...    title=Updated via PUT
    ...    completed=True

    ${response}=    Put On Session    ${SESSION}    ${posts}/${ID}   json=${body}

    Log To Console    Status Code : ${response.status_code}
    Log To Console    Response : ${response.json()}

    Should Be Equal As Integers    ${response.status_code}    ${statusCode}

Delete_Todo
    ${response}=    Delete On Session    ${SESSION}    ${posts}/${ID}
    Log To Console    Status Code : ${response.status_code}

    Should Be Equal As Integers    ${response.status_code}    ${statusCode}

