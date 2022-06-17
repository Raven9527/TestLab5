*** Settings ***
Suite Setup       Run Keywords    Open Keystonejs
...               AND    Login As Administrator
...               AND    Enter Post Page
Suite Teardown    Run Keyword    Log Out From Admin Page    # Library    Selenium2Library
Resource          resource.robot
Resource          posts.robot
Resource          ./local/TC-002.robot

*** Test Cases ***
Delete A Post Successfully
    [Tags]    TC-002a
    [Setup]    Run Keyword    Create A Post    test
    ${count} =    Get Feature Count
    Click Delete Post Button On Post List    test
    Click Delete Post Button On Delete Post Window
    Verify That The Post Is Deleted Successfully    test
    ${count_after_delete} =    Get Feature Count
    Should Not Be Equal    ${count}    ${count_after_delete}

Delete A Post Fail
    [Tags]    TC-002b
    [Setup]    Run Keyword    Create A Post    test
    ${count} =    Get Feature Count
    Click Delete Post Button On Post List    test
    Click Cancel Delete Post Button On Delete Post Window
    Verify That The Post Is Not Deleted    test
    ${count_after_delete} =    Get Feature Count
    Should Be Equal    ${count}    ${count_after_delete}
    [Teardown]    Run Keyword If Test Passed    Remove A Post   test