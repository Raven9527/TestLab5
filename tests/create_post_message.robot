*** Settings ***
Suite Setup       Run Keywords    Open Keystonejs
...               AND    Login As Administrator
Suite Teardown    Run Keyword    Log Out From Admin Page    # Library    Selenium2Library
Resource          resource.robot
Resource          posts.robot
Resource          ./local/TC-001.robot

*** Test Cases ***
Create a post should be shown on the admin ui page ISP1
    [Tags]    TC-001a-ISP1
    [Setup]    Enter Post Page
    Create Post Scenario    test123    Hi, there!
    [Teardown]    Run Keyword If Test Passed    Remove A Post   test123

Create a post should be shown on the admin ui page ISP2
    [Tags]    TC-001a-ISP2
    [Setup]    Enter Post Page
    Create Post Scenario    tetest123!@#$%^st    test123!@#$%^
    [Teardown]    Run Keyword If Test Passed    Remove A Post   tetest123!@#$%^st

Create a post should be shown on the admin ui page ISP3
    [Tags]    TC-001a-ISP3
    [Setup]    Enter Post Page
    Create Post Scenario    !#@ !~~E    !#@ !~~E
    [Teardown]    Run Keyword If Test Passed    Remove A Post   !#@ !~~E
    
Create A Post Fail With Invalid Title
    [Tags]    TC-001b
    Click Craete Post Button
    Input Post Title In Pop Windows    ${EMPTY}
    Click Craete Post Button In Pop Windows
    Verify That Have A Hint With Invalid Title
    Exit Pop Winodws
    Verify That Not Have A New Post In Post List    ${EMPTY}