*** Settings ***
Suite Setup       Run Keywords    Open Keystonejs
...               AND    Login As Administrator
Suite Teardown    Run Keyword    Log Out From Admin Page    # Library    Selenium2Library
Resource          resource.robot
Resource          category.robot
Resource          ./local/TC-007.robot

*** Test Cases ***
Create A Category With Valid Name ISP1
    [Tags]    TC-007a-ISP1
    [Setup]    Enter Category Page
    Create Category Scenario    Hi, there!
    [Teardown]    Run Keyword If Test Passed    TC-007's Teardown   Hi, there!
    
Create A Category With Valid Name ISP2
    [Tags]    TC-007a-ISP2
    [Setup]    Enter Category Page
    Create Category Scenario    test123!@#$%^
    [Teardown]    Run Keyword If Test Passed    TC-007's Teardown   test123!@#$%^
    
Create A Category With Valid Name ISP3
    [Tags]    TC-007a-ISP3
    [Setup]    Enter Category Page
    Create Category Scenario    !#@ !~~E
    [Teardown]    Run Keyword If Test Passed    TC-007's Teardown   !#@ !~~E

Create A Category Fail With Invalid Name
    [Tags]    TC-007b
    [Setup]    Enter Category Page
    ${count} =    Get Feature Count
    Click Craete Category Button
    Input Category Name In Pop Windows    ${EMPTY}
    Click Craete Category Button In Pop Windows
    Verify The Category Is Create Successfully    ${EMPTY}
    Verify That Have A Hint With Invalid Title
    Exit Pop Winodws
    Verify That Not Have A New Post In Post List    ${EMPTY}
    ${count_after_category} =    Get Feature Count
    Should Be Equal    ${count}    ${count_after_category}