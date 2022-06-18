*** Settings ***
Suite Setup       Run Keywords    Open Keystonejs
...               AND    Login As Administrator
Suite Teardown    Run Keyword    Log Out From Admin Page    # Library    Selenium2Library
Resource          resource.robot
Resource          comments.robot
Resource          ./local/TC-005.robot

*** Test Cases ***
Delete A Comment Successfully
    [Tags]    TC-005a
    [Setup]    Run Keyword    Enter Comment Page Without Create Post
    ${comment_id} =    Create A Comment    ${null}    ${null}
    ${count} =    Get Feature Count
    Click Delele Comment Button On Comment List    ${comment_id}
    Click Delete Button On Delete Comment Pop Windows
    Verify The Comment Is Deleted Successfully    ${comment_id}
    ${count_after_delete} =    Get Feature Count
    Should Not Be Equal    ${count}    ${count_after_delete}

Delete A Comment Fail
    [Tags]    TC-005b
    [Setup]    Run Keyword    Enter Comment Page Without Create Post
    ${comment_id} =    Create A Comment    ${null}    ${null}
    ${count} =    Get Feature Count
    Click Delele Comment Button On Comment List    ${comment_id}
    Click Cancel Button On Delete Comment Pop Windows
    Verify The Comment Is Deleted Fail    ${comment_id}
    ${count_after_delete} =    Get Feature Count
    Should Be Equal    ${count}    ${count_after_delete}
    [Teardown]    Run Keyword If Test Passed    Remove A Comment    ${comment_id}