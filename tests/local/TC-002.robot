*** Keywords ***
# TC-002a
Verify That The Post Is Deleted Successfully
    [Arguments]    ${post_title}
    ${post} =    Set Variable    //td[@class='ItemList__col']//*[normalize-space()='${post_title}']
    Wait Until Element Not Exist    ${post}

# TC-002b
Verify That The Post Is Not Deleted
    [Arguments]    ${post_title}
    ${post} =    Set Variable    //td[@class='ItemList__col']//*[normalize-space()='${post_title}']
    Wait For Element    ${post}