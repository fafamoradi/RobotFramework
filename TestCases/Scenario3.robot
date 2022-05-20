*** settings ***
Library   RequestsLibrary
Library   Collections

*** variables ***
${base_url}    https://reqres.in
${email}    email=sydney@fife

*** test cases ***
FirstTestCase
    create session    mysession    ${base_url}

    ${body}=    create dictionary    email=${email}
    ${header}=    create dictionary    Content-type=application/json
    ${response}=    post request    mysession    /api/register    data=${body}    headers=${header}
    log to console    ${response.status_code}
    log to console    ${response.content}

    ${status_code}=    convert to string    ${response.status_code}
    should be equal    ${status_code}    400





