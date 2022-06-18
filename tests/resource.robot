*** Settings ***
Documentation    This is the file where we define the reuse keywords.
Library          SeleniumLibrary
# Library          Selenium2Library

*** Variables ***
${SERVER}             localhost:3000
${BROWSER}            Edge
${DELAY}              0
${DEMO EMAIL}         demo@keystonejs.com
${DEMO USER}          Demo User
${DEMO PASSWORD}      demo
${URL}                http://${SERVER}
${POST FOR COMMENT}   Post for comment

*** Keywords ***
Open Keystonejs
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}

Login As Administrator
    Go To    ${URL}/keystone/signin
    ${Login Block}=    Set Variable    xpath://div[@class='auth-box']
    Wait For Element    ${Login Block}
    Input User Email       ${DEMO EMAIL}
    Input User Password    ${DEMO PASSWORD}
    ${Sign In Button}=    Set Variable    xpath://button[@type='submit']
    Wait For Element    ${Sign In Button}
    Click Button           ${Sign In Button}
    Wait For Element    xpath://div[@data-screen-id="home"]

Log Out From Admin Page
    ${Success}=    Run Keyword And Return Status    Click Element    xpath://a[@title='Sign Out']
    Run Keyword If    ${Success} == False    Click Element    xpath://a[text()='Sign Out']
    Close Browser

Enter Post Page
    ${Post Tag}=    Set Variable    xpath://a[text()='Posts']
    Wait For Element    ${Post Tag}
    Click Link    ${Post Tag}
    Wait For Post List Block

Enter User Page
    Go To    ${URL}/keystone/users
    Wait For Element    //nav[@class="secondary-navbar"]//a[text()='Users']

Enter Contact Page
    Go To    ${url}/contact
    Wait For Element    xpath://body//div[@class="container"]

Enter Comment Page
    Enter Post Page
    Create A Post    ${POST FOR COMMENT}
    ${Home Link}=    Set Variable    xpath://li[@data-section-label="octicon-home"]/a
    Click Link    ${Home Link}
    ${Comments Link}=    Set Variable    xpath://div[@data-list-path='post-comments']//a
    Wait For Element    ${Comments Link}
    Click Link    ${Comments Link}
    ${Comment List}=    Set Variable    xpath://div[@data-screen-id='list']
    Wait For Element    ${Comment List}

Enter Comment Page Without Create Post
    ${Home Link}=    Set Variable    xpath://li[@data-section-label="octicon-home"]/a
    Click Link    ${Home Link}
    ${Comments Link}=    Set Variable    xpath://div[@data-list-path='post-comments']//a
    Wait For Element    ${Comments Link}
    Click Link    ${Comments Link}
    ${Comment List}=    Set Variable    xpath://div[@data-screen-id='list']
    Wait For Element    ${Comment List}

Enter Category Page
    ${Category Link}=    Set Variable    xpath://div[@data-list-path="post-categories"]//a[@class="dashboard-group__list-tile"]
    Wait For Element    ${Category Link}
    Click Link    ${Category Link}
    Wait For Element    xpath://div[@data-screen-id="list"]

Leave Comment Page and Log out
    ${Post Tag}=    Set Variable    xpath://nav[@class="secondary-navbar"]//a[text()='Posts']
    Wait For Element    ${Post Tag}
    Click Link    ${Post Tag}
    Wait For Post List Block
    Remove A Post    ${POST FOR COMMENT}
    Log Out From Admin Page

Wait For Feature List Block
    ${Post List Block}=    Set Variable    xpath://div[@data-screen-id='list']
    Wait For Element    ${Post List Block}

Wait For Post List Block
    ${Post List Block}=    Set Variable    xpath://div[@data-screen-id='list']
    Wait For Element    ${Post List Block}

Wait For Element
    [Arguments]    ${element}
    Wait Until Page Contains Element    ${element}    10
    Wait Until Element Is Visible    ${element}    10
    Wait Until Element Is Enabled    ${element}    10

Wait For Element By Time
    [Arguments]    ${element}    ${timeout}
    Wait Until Page Contains Element    ${element}    ${timeout}
    Wait Until Element Is Visible    ${element}    ${timeout}
    Wait Until Element Is Enabled    ${element}    ${timeout}

Wait Until Element Not Exist
    [Arguments]    ${element}
    Wait Until Element Is Not Visible    ${element}    timeout=10

Input User Email
    [Arguments]    ${email}
    ${Email Field}=    Set Variable    xpath://input[@name='email']
    Wait For Element    ${Email Field}
    Input Text    ${Email Field}    ${email}

Input User Password
    [Arguments]    ${password}
    ${Password Field}=    Set Variable    xpath://input[@name='password']
    Wait For Element    ${Password Field}
    Input Text    ${Password Field}    ${password}

Click Menu List
    [Arguments]    ${menu}
    Click Menu Element    ${menu}
    ${Success}=    Run Keyword And Return Status    Wait Until Page Does Not Contain Element    ${menu}
    Run Keyword If    ${Success} == False    Click Menu Element    ${menu}

Click Menu Element
    [Arguments]    ${menu}
    Wait For Element    ${menu}
    Click Element    ${menu}

Get Feature Count
    ${count} =    Get Element Count    //tbody//tr
    [Return]    ${count}

Switch To Post Page
    ${link} =    Set Variable    //*[@data-list-path='posts']//a[@href='/keystone/posts']
    Click Link    ${link}
    Wait For Post List Block

Switch To Comment Page
    ${link} =    Set Variable    //*[@data-list-path='post-comments']//a[@href='/keystone/post-comments']
    Click Link    ${link}
    Wait For Post List Block

Switch To Category Page
    ${link} =    Set Variable    //*[@data-list-path='post-categories']//a[@href='/keystone/post-categories']
    Click Link    ${link}
    Wait For Post List Block

Exit Pop Winodws
    ${windows} =    Set Variable    //*[@data-screen-id='modal-dialog']
    ${cancel_button} =    Set Variable    //button[@data-button-type='cancel' and normalize-space()='Cancel']
    Click Button    ${cancel_button}
    Wait Until Element Not Exist  ${windows}

Go To Demo Page
    ${demo_page} =    Set Variable    //*[@title='Front page - Demo']
    Wait For Element    ${demo_page}
    Click Element    ${demo_page}

Go To Blog Page
    Go To Demo Page
    ${blog_page} =    Set Variable    //li[normalize-space()='Blog']//a
    Wait For Element    ${blog_page}
    Click Element    ${blog_page}
    Wait For Element    //*[@class='page-header']//*[normalize-space()='Blog']

Select Category On Blog post_message
    [Arguments]    ${category}
    ${category_field} =    Set Variable    //li[@role='presentation']//a[@href='/blog/${category}']
    Wait For Element    ${category_field}
    Click Element    ${category_field}
    Wait For Element    //*[@class='page-header']//*[normalize-space()='${category}']

Go To Admin Page
    ${admin_link} =    Set Variable    //*[@id='navbar-collapse']//*[normalize-space()='Admin UI']//a
    Wait For Element    ${admin_link}
    Click Element    ${admin_link}

Go Home 
    ${home} =    Set Variable    //*[@title='Dashboard - Demo']
    Wait For Element    ${home}
    Click Element    ${home}