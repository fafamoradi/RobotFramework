*** settings ***
Library   RequestsLibrary
Library   Collections
Library     	JSONLibrary
Library    ../Libraries/CustumLib.py

*** variables ***
${base_url}    https://reqres.in
${job}    leader
${currentName}    morpheus
${currentEmail}    morpheus@gmail.com
${newName}    david
${newEmail}    david@gmail.com

*** test cases ***
FirstTestCase
    create session    mysession    ${base_url}

    ${body}=    create dictionary    name=${currentName}    job=${job}    email=${currentEmail}
    ${header}=    create dictionary    Content-type=application/json
    ${response}=    post request    mysession    /api/users    data=${body}    headers=${header}

    ${json_object}= 	Convert String to JSON    ${response.content}
    ${json_object}=    Update Value To Json    ${json_object}    $.name    ${newName}
    ${json_object}=    Update Value To Json    ${json_object}    $.email    ${newEmail}
    ${newResponse}=    post request    mysession    /api/users    data=${json_object}    headers=${header}
    log to console    ${newResponse.content}


#    validate name and email
    ${res_body}=    convert to string    ${json_object}
    should contain    ${res_body}    ${newName}
    should contain    ${res_body}    ${newEmail}

#    validation id range
    ${id}=    Get Value From Json    ${json_object}    $.id
    log to console    ${id[0]}
    Should Be True 	99 < ${id[0]} < 1000


#    validate jalali date format
    ${date}=    Get Value From Json    ${json_object}    $.createdAt
    ${stringDate}=    convert to string    ${date[0]}
    log to console    ${stringDate}
    ${final}=    convertDate    ${stringDate}
    log to console    ${final}
