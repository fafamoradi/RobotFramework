*** settings ***
Library   RequestsLibrary
Library   Collections
Library     	JSONLibrary
Library    ../TestCases/CustumLib.py

*** variables ***
${base_url}    https://reqres.in
${name}    david
${job}    leader
${email}    david@gmail.com


*** test cases ***
FirstTestCase
    create session    mysession    ${base_url}

    ${body}=    create dictionary    name=${name}    job=${job}    email=${email}
    ${header}=    create dictionary    Content-type=application/json
    ${response}=    post request    mysession    /api/users    data=${body}    headers=${header}
#    log to console    ${response.content}


#    validate name and email
    ${res_body}=    convert to string    ${response.content}
    should contain    ${res_body}    ${name}
    should contain    ${res_body}    ${email}

#    validation id range
    ${json_object}= 	Convert String to JSON    ${response.content}
    ${id}=    Get Value From Json    ${json_object}    $.id
    log to console    ${id[0]}
    Should Be True 	99 < ${id[0]} < 1000


#    validate jalali date format
    ${json_object}= 	Convert String to JSON    ${response.content}
    ${date}=    Get Value From Json    ${json_object}    $.createdAt
    ${stringDate}=    convert to string    ${date[0]}
    log to console    ${stringDate}
    ${final}=    convertDate    ${stringDate}
    log to console    ${final}