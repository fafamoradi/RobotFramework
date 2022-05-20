*** settings ***
Library   RequestsLibrary
Library   Collections

*** variables ***
${base_url}    https://reqres.in
${name}    morpheus
${job}    leader


*** test cases ***
FirstTestCase
    create session    mysession    ${base_url}

    ${body}=    create dictionary    name=${name}    job=${job}
    ${header}=    create dictionary    Content-type=application/json
    ${response}=    post request    mysession    /api/users    data=${body}    headers=${header}

    log to console    ${response.content}
    ${status_code}=    convert to string    ${response.status_code}
    should be equal    ${status_code}    201

    ${res_body}=    convert to string    ${response.content}
    should contain    ${res_body}    ${name}
    should contain    ${res_body}    ${job}




