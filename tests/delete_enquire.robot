*** Settings ***
Suite Setup       Run Keywords    Open Keystonejs
...               AND    Login As Administrator
Suite Teardown    Run Keyword    Log Out From Admin Page    # Library    Selenium2Library
Resource          resource.robot
Resource          enquire.robot
Resource          ./local/TC-010.robot

*** Variables ***
${OPTION_REQUIRED}   (required)
${OPTION_MESSAGE}    Just leaving a message
${OPTION_QUESTION}   I've got a question
${OPTION_OTHER}      Something else...

*** Test Cases ***
Delete A Enquire Successfully
    [Tags]    TC-010-a
    [Setup]    Go To Contact Page
    Input Enquire Information On Contact Page    test    t110598108@ntut.org.tw    0912345678    ${OPTION_MESSAGE}    Hi, there!
    Go To Admin UI After Create Enquire
    ${count} =    Get Feature Count
    Remove A Enquire    test
    Verify The Enquire Is Delete Successfully    test
    ${count_after_detele} =    Get Feature Count
    Should Not Be Equal    ${count}    ${count_after_detele}
    
Delete A Enquire Fail
    [Tags]    TC-010-a
    [Setup]    Go To Contact Page
    Input Enquire Information On Contact Page    test    t110598108@ntut.org.tw    0912345678    ${OPTION_MESSAGE}    Hi, there!
    Go To Admin UI After Create Enquire
    ${count} =    Get Feature Count
    Click Delete Enquire Button On Enquire List    test
    Click Cancel Button On Delete Enquire Pop Window
    Verify The Enquire Is Delete Fail    test
    ${count_after_detele} =    Get Feature Count
    Should Be Equal    ${count}    ${count_after_detele}
    [Teardown]    Run Keyword If Test Passed    Remove A Enquire   test