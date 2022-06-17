*** Keywords ***
# TC-004a
Verify The Author And Post Is Correct Of The New Comment
    [Arguments]    ${author}    ${post}
    Run Keyword If    $author is None    Verify Author Field Is Null    ELSE    Verify Author Field Have Element    ${author}
    Run Keyword If    $post is None    Verify Post Field Is Null    ELSE    Verify Post Field Have Element    ${post}

###
Verify Author Field Is Null
    ${author} =    Set Variable    Select...
    ${author_field} =    Set Variable    //div[@for='author']//div[@class='Select-placeholder']
    Wait For Element  ${author_field}
    ${author_text} =    Get Text    ${author_field}
    Should Be Equal    ${author_text}    ${author}

Verify Author Field Have Element
    [Arguments]    ${author}
    ${author_field} =    Set Variable    //div[@for='author']//div[@class='Select-value']
    Wait For Element  ${author_field}
    ${author_text} =    Get Text    ${author_field}
    Should Be Equal    ${author_text}    ${author}

Verify Post Field Is Null
    ${post} =    Set Variable    Select...
    ${post_field} =    Set Variable    //div[@for='post']//div[@class='Select-placeholder']
    Wait For Element  ${post_field}
    ${post_text} =    Get Text    ${post_field}
    Should Be Equal    ${post_text}    ${post}

Verify Post Field Have Element
    [Arguments]    ${post}
    ${post_field} =    Set Variable    //div[@for='post']//div[@class='Select-value']
    Wait For Element  ${post_field}
    ${post_text} =    Get Text    ${post_field}
    Should Be Equal    ${post_text}    ${post}
###

Verify That A New Comment Is Created Successfully On Comment List
    [Arguments]    ${id}
    ${id_field} =    Set Variable    //a[@title='${id}']
    Wait For Element    ${id_field}

TC 004's Teardown
    [Arguments]    ${post_name}    ${comment_id}
    Remove A Comment   ${comment_id}
    Switch To Post Page
    Remove A Post  ${post_name}

### Template
Create A Comment With Author And Post
    [Arguments]    ${author}    ${post}
    ${count} =    Get Feature Count
    Click Craete Comment Button
    Input Comment Author In Pop Windows    ${author}
    Input Comment Post In Pop Windows    ${post}
    Click Craete Comment Button In Pop Windows
    Verify The Author And Post Is Correct Of The New Comment    ${author}    ${post}
    ${comment_id} =    Get Comment ID
    Back To Comment List In Comment View
    Verify That A New Comment Is Created Successfully On Comment List    ${comment_id}
    ${after_create_count} =    Get Feature Count
    Should Not Be Equal    ${count}    ${after_create_count}
    [Return]    ${comment_id}