*** Settings ***
Suite Setup       Run Keywords    Open Keystonejs
...               AND    Login As Administrator
Suite Teardown    Run Keyword    Log Out From Admin Page    # Library    Selenium2Library
Resource          resource.robot
Resource          posts.robot
Resource          category.robot
Resource          ./local/TC-008.robot

*** Test Cases ***
Show Post Of Category On Blog Happy Path
    [Tags]    TC-008a
    [Setup]    Enter Post Page
    Create A Post    default
    Switch To Category Page
    Create A Category    category
    Switch To Post Page
    Select Post On Post List    default
    Input Comment State In Post View    Published
    Click Save Post Button In Post View
    Back To Post List In Post View
    Select Post On Post List    default
    Input Category In Post View    category
    Click Save Post Button In Post View
    Go To Blog Page
    Select Category On Blog post_message    category
    Verify Post In Blog Category Page    default
    Verify That If The Renderings Of All Corresponding Pages Follow The Design    category
    [Teardown]    Run Keyword If Test Passed    TC-008's Teardown    default    category