*** Keywords ***
# TC-006a
Verify The Comment Is Edited Successfully
    ${hint_field} =    Set Variable    //*[@data-alert-type='success']
    Wait For Element    ${hint_field}
    ${hint_text} =    Get Text    //*[@data-alert-type='success']
    Should Be Equal As Strings    Your changes have been saved successfully    ${hint_text}

Verify Comment Information Is Correct
    [Arguments]    ${author}    ${post}    ${state}    ${message}
    ${author_field} =    Set Variable    //label[@for='author']//..//div[@class='FormField__inner field-size-full']//*[@class='Select-input']//input//..//preceding-sibling::div
    ${post_field} =    Set Variable    //label[@for='post']//..//div[@class='FormField__inner field-size-full']//*[@class='Select-input']//input//..//preceding-sibling::div
    ${state_field} =    Set Variable    //label[@for='commentState']//..//div[@class='FormField__inner field-size-full']//*[@class='Select-input']//input//..//preceding-sibling::div
    ${content_frame} =    Set Variable    //*[@class='FormField__inner field-size-full']//iframe

    Wait For Element    ${author_field}
    Wait For Element    ${post_field}
    Wait For Element    ${state_field}
    Wait For Element    ${content_frame}

    ${author_text} =    Get Text    ${author_field}
    ${post_text} =    Get Text    ${post_field}
    ${state_text} =    Get Text    ${state_field}

    Select Frame    ${content_frame}
    Wait For Element    tinymce
    ${content_text} =    Get Text    //*[@id='tinymce']
    Unselect Frame

    Run Keyword If    $author is None    Should Be Equal    Select...    ${author_text}    ELSE    Should Be Equal    ${author}    ${author_text}
    Run Keyword If    $post is None    Should Be Equal    Select...    ${post_text}    ELSE    Should Be Equal    ${post}    ${post_text}
    Should Be Equal    ${state}    ${state_text}
    Should Be Equal    ${message}    ${content_text}

TC 006's Teardown
    [Arguments]    ${post_name}    ${comment_id}
    Remove A Comment   ${comment_id}
    Switch To Post Page
    Remove A Post  ${post_name}

Edit Comment Scenario
    [Arguments]    ${author}    ${post}    ${state}    ${message}
    ${comment_id} =    Create A Comment    ${null}    ${null}
    Select Comment On Comment List    ${comment_id}
    Input Comment Information In Comment View    ${author}    ${post}    ${state}    ${message}
    Save Comment Button On Comment View
    Verify The Comment Is Edited Successfully
    Back To Comment List In Comment View
    Select Comment On Comment List    ${comment_id}
    Verify Comment Information Is Correct    ${author}    ${post}    ${state}    ${message}
    Back To Comment List In Comment View
    [Return]    ${comment_id}