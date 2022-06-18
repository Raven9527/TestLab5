*** Keywords ***
# TC-005a
Verify The Comment Is Deleted Successfully
    [Arguments]    ${id}
    Wait Until Element Not Exist  //*[normalize-space()='${id}']

# TC-005b
Verify The Comment Is Deleted Fail
    [Arguments]    ${id}
    Wait For Element    //*[normalize-space()='${id}']
