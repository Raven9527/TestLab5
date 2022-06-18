*** Keywords ***
# TC-001a
Verify The Hint Message Show In Header When Save Post Successfully
    ${hint_field} =    Set Variable    //*[@data-alert-type='success']
    Wait For Element    ${hint_field}
    ${hint_text} =    Get Text    //*[@data-alert-type='success']
    Should Be Equal As Strings    Your changes have been saved successfully    ${hint_text}

Verify That Have A New Post Is Created Successfully In Post List
    [Arguments]    ${post_title}
    ${post} =    Set Variable    //td[@class='ItemList__col']//*[normalize-space()='${post_title}']
    Wait For Element    ${post}

# TC-001b
Verify That Have A Hint With Invalid Title
    ${hint_field} =    Set Variable    //div[@data-alert-type='danger']/div
    Wait For Element    ${hint_field}
    ${hint_text} =    Get Text    ${hint_field}
    Should Be Equal As Strings    Name is required    ${hint_text}

Verify That Not Have A New Post In Post List
    [Arguments]    ${post_title}
    ${post} =    Set Variable    //td[@class='ItemList__col']//*[normalize-space()='${post_title}']
    Wait Until Element Not Exist    ${post}

Create Post Scenario
    [Arguments]    ${post_name}    ${post_message}
    Click Craete Post Button
    Input Post Title In Pop Windows    ${post_name}
    Click Craete Post Button In Pop Windows
    Input Post Message In Post View    ${post_message}
    Click Save Post Button In Post View
    Verify The Hint Message Show In Header When Save Post Successfully
    Back To Post List In Post View
    Verify That Have A New Post Is Created Successfully In Post List    ${post_name}