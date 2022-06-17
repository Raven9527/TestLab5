*** Settings ***
Suite Setup       Run Keywords    Open Keystonejs
...               AND    Login As Administrator
...               AND    Enter Post Page
Suite Teardown    Run Keyword    Log Out From Admin Page    # Library    Selenium2Library
Resource          resource.robot
Resource          posts.robot
Resource          ./local/TC-001.robot

*** Test Cases ***
Create a post should be shown on the admin ui page
    [Tags]    TC-001a
    Click Craete Post Button
    Input Post Title In Pop Windows    test
    Click Craete Post Button In Pop Windows
    Input Post Message In Post View    Hi, there!
    Click Save Post Button In Post View
    Verify The Hint Message Show In Header When Save Post Successfully
    Back To Post List In Post View
    Verify That Have A New Post Is Created Successfully In Post List    test
    [Teardown]    Run Keyword If Test Passed    Remove A Post   test

Create A Post Fail With Invalid Title
    [Tags]    TC-001b
    Click Craete Post Button
    Input Post Title In Pop Windows    ${EMPTY}
    Click Craete Post Button In Pop Windows
    Verify That Have A Hint With Invalid Title
    Exit Pop Winodws
    Verify That Not Have A New Post In Post List    ${EMPTY}