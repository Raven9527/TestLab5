*** Settings ***
Suite Setup       Run Keywords    Open Keystonejs
...               AND    Login As Administrator
...               AND    Enter Post Page
Suite Teardown    Run Keyword    Log Out From Admin Page    # Library    Selenium2Library
Resource          resource.robot
Resource          posts.robot
Resource          ./local/TC-003.robot

*** Test Cases ***
Edit A Post Successfully
    [Tags]    TC-003a
    [Setup]    Run Keyword    Create A Post With Title And Message    default    default
    Select Post On Post List    default
    Input Post Titel In Post View    test
    Input Post Message In Post View    Hi, there!
    Click Save Post Button In Post View
    Verify The Hint Message Show In Header When Save Post Successfully
    Back To Post List In Post View
    Verify That Have A Post Is Edited Successfully In Post List    test
    [Teardown]    Run Keyword If Test Passed    Remove A Post   test

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