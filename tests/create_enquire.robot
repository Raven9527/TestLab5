*** Settings ***
Suite Setup       Run Keywords    Open Keystonejs
...               AND    Login As Administrator
Suite Teardown    Run Keyword    Log Out From Admin Page    # Library    Selenium2Library
Resource          resource.robot
Resource          enquire.robot
Resource          ./local/TC-009.robot

*** Variables ***
${OPTION_REQUIRED}   (required)
${OPTION_MESSAGE}    Just leaving a message
${OPTION_QUESTION}   question
${OPTION_OTHER}      Something else...

*** Test Cases ***
Create A Enquire ISP1
    [Tags]    TC-009a-ISP1
    [Setup]    Go To Contact Page
    Input Enquire Information On Contact Page    test    t110598108@ntut.org.tw    0912345678    ${OPTION_MESSAGE}    Hi, there!
    Go To Admin UI After Create Enquire
    Verify The Enquire Is Create Successfully    test    t110598108@ntut.org.tw
    [Teardown]    Run Keyword If Test Passed    Remove A Enquire   test

Create A Enquire ISP2
    [Tags]    TC-009a-ISP2
    [Setup]    Go To Contact Page
    Input Enquire Information On Contact Page    test!!123    t110598108@ntut.org.tw    test!!123    ${OPTION_QUESTION}    test!!123
    Go To Admin UI After Create Enquire
    Verify The Enquire Is Create Successfully    test!!123    t110598108@ntut.org.tw
    [Teardown]    Run Keyword If Test Passed    Remove A Enquire   test!!123

Create A Enquire ISP3
    [Tags]    TC-009a-ISP3
    [Setup]    Go To Contact Page
    Input Enquire Information On Contact Page    !@!#E$%^&***@+-*/    t110598108@ntut.org.tw    !@!#E$%^&***@+-*/    ${OPTION_OTHER}    !@!#E$%^&***@+-*/
    Go To Admin UI After Create Enquire
    Verify The Enquire Is Create Successfully    !@!#E$%^&***@+-*/    t110598108@ntut.org.tw
    [Teardown]    Run Keyword If Test Passed    Remove A Enquire   !@!#E$%^&***@+-*/

Create A Enquire ISP4
    [Tags]    TC-009a-ISP4
    [Setup]    Go To Contact Page
    Input Enquire Information On Contact Page    !E E!    t110598108@ntut.org.tw    !E E!    ${OPTION_MESSAGE}    !E E!
    Go To Admin UI After Create Enquire
    Verify The Enquire Is Create Successfully    !E E!    t110598108@ntut.org.tw
    [Teardown]    Run Keyword If Test Passed    Remove A Enquire   !E E!
    
Create A Enquire Fail With Invalid Name
    [Tags]    TC-009b
    [Setup]    Go To Contact Page
    Input Enquire Information On Contact Page    ${EMPTY}    t110598108@ntut.org.tw    0912345678    ${OPTION_MESSAGE}    Hi, there!
    Verify The Enquire Is Create Successfully    !E E!    t110598108@ntut.org.tw
    