*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}    https://jsonplaceholder.typicode.com
${ID}          10
${statusCode}    200
${postStatusCode}    201

*** Test Cases ***
Get_Todo
    Create Session    mysession    ${BASE_URL}
    ${response}=    GET On Session    mysession    /todos/${ID}
    Log To Console    Status Code: ${response.status_code}
    #Log To Console    Response Body: ${response.text}
    #Log To Console    Headers: ${response.headers}

    ${newStatusCode}=    convert To string    ${response.status_code}
    should be equal    ${statusCode}    ${newStatusCode}

    ${body}    convert to string    ${response.content}
    should contain    ${body}    true

Post_Todo
    ${body}=    Create Dictionary    userId=107    id=107    title=Robot    completed=True
    ${response}=    Post On Session    mysession    /posts    json=${body}

    Log To Console    Status Code : ${response.status_code}
    Log To Console    Response : ${response.json()}

    ${newStatusCode}     convert to String    ${response.status_code}
    should be equal    ${newStatusCode}    ${postStatusCode}

Patch_Todo
    ${body}=    Create Dictionary    title=Updated Robot Title    completed=True
    ${response}=    Patch On Session    mysession    /posts/${ID}   json=${body}

    Log To Console    Status Code : ${response.status_code}
    Log To Console    Response : ${response.json()}

    Should Be Equal As Integers    ${response.status_code}    ${statusCode}

Update_Todo_PUT
    ${body}=    Create Dictionary
    ...    userId=1
    ...    id=1
    ...    title=Updated via PUT
    ...    completed=True

    ${response}=    Put On Session    mysession    /posts/${ID}   json=${body}

    Log To Console    Status Code : ${response.status_code}
    Log To Console    Response : ${response.json()}

    Should Be Equal As Integers    ${response.status_code}    ${statusCode}

Delete_Todo
    ${response}=    Delete On Session    mysession    /posts/1
    Log To Console    Status Code : ${response.status_code}

    Should Be Equal As Integers    ${response.status_code}    ${statusCode}

