*** settings ***
Library   RequestsLibrary
Library   Collections

*** variables ***
${base_url}    https://reqres.in
${name}    morpheus
${job}    leader
${email}    morpheus@gmail.com
${country}    Thailand

*** test cases ***
FirstTestCase
    create session    mysession    ${base_url}

    ${body}=    create dictionary    name=${name}    job=${job}    email=${email}
    Set To Dictionary   ${body}    country    ${country}
    ${header}=    create dictionary    Content-type=application/json
    ${response}=    post request    mysession    /api/users    data=${body}    headers=${header}

    log to console    ${response.status_code}
    log to console    ${response.content}
    ${res_body}=    convert to string    ${response.content}
    should contain    ${res_body}    ${country}
