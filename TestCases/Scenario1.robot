*** settings ***
Library     	JSONLibrary
Library   RequestsLibrary
Library   Collections


*** variables ***
${base_url}    https://gorest.co.in
${val}    "1"


*** test cases ***
First TestCase
    create session    api1session    ${base_url}
    ${response} =    GET On Session    api1session    /public/v1/posts/123/comments
    log to console    ${response.content}
    ${json_object}= 	Convert String to JSON 	${response.content}


    ${page_value}=    Get Value From Json    ${json_object}    $.meta.pagination.page
    log to console    ${page_value[0]}
    Should be equal as strings    ${page_value[0]}    1

    ${data}=    Get Value From Json    ${json_object}    $.data
    log to console    ${data[0]}
    Should be equal as strings    ${data[0]}    []