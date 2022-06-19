*** Keywords ***
# TC-009a
Verify That Have Success Hint
    Wait For Create Enquire Success

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

# TC-009b
Verify Invalid Input So That Create Fail
    ${submit_button} =    Set Variable    //*[@type='submit']
    ${Verify}=    Run Keyword And Return Status    Wait For Element By Time    ${submit_button}    3
    Should Be Equal    'True'    '${Verify}'
    ${block} =    Set Variable    //div[@class='jumbotron text-center']//*[normalize-space()='Success!']
    Wait Until Element Not Exist By Time    ${block}    3

Verify That Error Page
    ${field} =    Set Variable    //*[@class='error-title']
    Wait For Element    ${field}

Refrash Web
    ${contact_page} =    Set Variable    //li[normalize-space()='Contact']//a
    Wait For Element    ${contact_page}
    Click Element    ${contact_page}
    Wait For Element    //*[@class='page-header']//*[normalize-space()='Contact']