*** Keywords ***
# TC-009a
Verify The Enquire Is Create Successfully
    [Arguments]    ${name}    ${email}
    ${name_field} =    Set Variable    //td[@class='ItemList__col']//*[normalize-space()='${name}']
    ${email_field} =    Set Variable    //td[@class='ItemList__col']//*[normalize-space()='${email}']
    
    Wait For Element    ${name_field}
    Wait For Element    ${email_field}

    ${name_text} =    Get Text    ${name_field}
    ${email_text} =    Get Text    ${email_field}

    Should Be Equal As Strings    ${name}    ${name_text}
    Should Be Equal As Strings    ${email}    ${email_text}

Verify That Have A New Category Is Created Successfully In Category List
    [Arguments]    ${category_name}
    ${post} =    Set Variable    //td[@class='ItemList__col']//*[normalize-space()='${category_name}']
    Wait For Element    ${post}

# TC-007b
Verify That Have A Hint With Invalid Title
    ${hint_field} =    Set Variable    //div[@data-alert-type='danger']/div
    Wait For Element    ${hint_field}
    ${hint_text} =    Get Text    ${hint_field}
    Should Be Equal As Strings    Name is required    ${hint_text}

Verify That Not Have A New Post In Post List
    [Arguments]    ${category_name}
    ${post} =    Set Variable    //td[@class='ItemList__col']//*[normalize-space()='${category_name}']
    Wait Until Element Not Exist    ${post}

Create Enquire Scenario
    [Arguments]    ${name}    ${email}    ${phone}    ${regarding}    ${Message}
    ${count} =    Get Feature Count
    Click Craete Category Button
    Input Category Name In Pop Windows    ${name}
    Click Craete Category Button In Pop Windows
    Verify The Category Is Create Successfully    ${name}
    Back To Category List In Post View
    Verify That Have A New Category Is Created Successfully In Category List    ${name}
    ${count_after_category} =    Get Feature Count
    Should Not Be Equal    ${count}    ${count_after_category}

TC-009's Teardown
    [Arguments]    ${category}
    Remove A Category   ${category}
    Go Home