*** Settings ***
Suite Setup       Run Keywords    Open Keystonejs
...               AND    Login As Administrator
...               AND    Enter Post Page
Suite Teardown    Run Keyword    Log Out From Admin Page    # Library    Selenium2Library
Resource          resource.robot
Resource          posts.robot
Resource          ./local/TC-003.robot

*** Test Cases ***
Edit A Post Successfully ISP1
    [Tags]    TC-003a-ISP1
    [Setup]    Enter Post Page
    Edit Post Scenario    test    Hi, there!
    [Teardown]    Run Keyword If Test Passed    Remove A Post   test

Edit A Post Successfully ISP2
    [Tags]    TC-003a-ISP2
    [Setup]    Enter Post Page
    Edit Post Scenario    test123!@#$@%^$^    test123!@#$@%^$^
    [Teardown]    Run Keyword If Test Passed    Remove A Post   test123!@#$@%^$^
    
Edit A Post Successfully ISP3
    [Tags]    TC-003a-ISP3
    [Setup]    Enter Post Page
    Edit Post Scenario    !#@ !~~E    !#@ !~~E
    [Teardown]    Run Keyword If Test Passed    Remove A Post   !#@ !~~E

Edit A Post Fail
    [Tags]    TC-003b
    [Setup]    Run Keyword    Create A Post With Title And Message    default    default
    Select Post On Post List    default
    Input Post Message In Post View    ${EMPTY}
    Input Post Titel In Post View    ${EMPTY}
    Click Save Post Button In Post View
    Verify That Have A Hint With Invalid Title
    Back To Post List In Post View
    Verify That Not Have A Edited Post In Post List    ${EMPTY}
    [Teardown]    Run Keyword If Test Passed    Remove A Post   default