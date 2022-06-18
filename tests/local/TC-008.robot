*** Keywords ***
# TC-007a
Verify Post In Blog Category Page
    [Arguments]    ${post_name}
    ${post_field} =    Set Variable    //*[@class='row']//*[@class='media-heading']//*[normalize-space()='${post_name}']
    Wait For Element    ${post_field}

Verify That If The Renderings Of All Corresponding Pages Follow The Design
    [Arguments]    ${category}
    ${category_field}    Set Variable    //*[@class='page-header']//*[normalize-space()='${category}']
    Wait For Element    ${category_field}

TC-008's Teardown
    [Arguments]    ${post_name}    ${category_name}
    Go To Admin Page
    Enter Post Page
    Remove A Post    ${post_name}
    Switch To Category Page
    Remove A Category    ${category_name}