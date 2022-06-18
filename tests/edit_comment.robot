*** Settings ***
Suite Setup       Run Keywords    Open Keystonejs
...               AND    Login As Administrator
Suite Teardown    Run Keyword    Log Out From Admin Page    # Library    Selenium2Library
Resource          resource.robot
Resource          posts.robot
Resource          comments.robot
Resource          ./local/TC-006.robot

*** Test Cases ***
Edit A Comment With Valid Infomation
    [Tags]    TC-006a
    [Setup]    Run Keyword    Enter Comment Page
    ${comment_id} =    Edit Comment Scenario    Demo User    ${POST FOR COMMENT}    Published    test
    [Teardown]    Run Keyword If Test Passed    TC 006's Teardown    ${POST FOR COMMENT}    ${comment_id}

Edit A Comment Reset Changes
    [Tags]    TC-006b
    [Setup]    Run Keyword    Enter Comment Page
    ${comment_id} =    Create A Comment    ${null}    ${null}
    Select Comment On Comment List    ${comment_id}
    Input Comment Information In Comment View    Demo User    ${POST FOR COMMENT}    Published    test
    Reset Change Button On Comment View
    Back To Comment List In Comment View
    Select Comment On Comment List    ${comment_id}
    Verify Comment Information Is Correct    ${null}    ${null}    Published    ${EMPTY}
    Back To Comment List In Comment View
    [Teardown]    Run Keyword If Test Passed    TC 006's Teardown    ${POST FOR COMMENT}    ${comment_id}