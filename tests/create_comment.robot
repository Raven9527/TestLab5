*** Settings ***
Suite Setup       Run Keywords    Open Keystonejs
...               AND    Login As Administrator
Suite Teardown    Run Keyword    Log Out From Admin Page    # Library    Selenium2Library
Resource          resource.robot
Resource          posts.robot
Resource          comments.robot
Resource          ./local/TC-004.robot

*** Test Cases ***
Create A Comment With Null Author And Null Post
    [Tags]    TC-004a-1
    [Setup]    Run Keyword    Enter Comment Page
    ${comment_id} =    Create A Comment With Author And Post    ${null}    ${null}
    [Teardown]    Run Keyword If Test Passed    TC 004's Teardown    ${POST FOR COMMENT}    ${comment_id}

Create A Comment With Valid Author And Valid Post
    [Tags]    TC-004a-2
    [Setup]    Run Keyword    Enter Comment Page
    ${comment_id} =    Create A Comment With Author And Post    Demo User    ${POST FOR COMMENT}
    [Teardown]    Run Keyword If Test Passed    TC 004's Teardown    ${POST FOR COMMENT}    ${comment_id}