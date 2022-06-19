*** Keywords ***
# TC-010a
Verify The Enquire Is Delete Successfully
    [Arguments]    ${name}
    ${enquire} =    Set Variable    //td[@class='ItemList__col']//*[normalize-space()='${name}']
    Wait Until Element Not Exist    ${enquire}

# TC-010b
Verify The Enquire Is Delete Fail
    [Arguments]    ${name}
    ${enquire} =    Set Variable    //td[@class='ItemList__col']//*[normalize-space()='${name}']
    Wait For Element    ${enquire}
