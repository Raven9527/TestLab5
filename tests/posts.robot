*** Settings ***
Documentation    This is the file where we define the post reuse keywords.
Library          SeleniumLibrary
# Library          Selenium2Library
Resource          resource.robot

*** Keywords ***
# create
Click Craete Post Button 
    ${Create First Post Button}=    Set Variable    xpath://button[contains(text(),'Create')]
    ${Create Other Post Button}=    Set Variable    xpath://button[@title='Create Post']
    ${Is First Time}=    Run Keyword And Return Status    Wait For Element    ${Create First Post Button}
    ${Create Post Button}=    Run Keyword If    ${Is First Time} == True    Set Variable    ${Create First Post Button}
    ...    ELSE    Set Variable    ${Create Other Post Button}
    Wait For Element    ${Create Post Button}
    Click Button   ${Create Post Button}

Input Post Title In Pop Windows
    [Arguments]    ${post name}
    Input Text    name:name    ${post name}
    
Click Craete Post Button In Pop Windows
    ${Create Button} =    Set Variable    xpath://button[text()='Create']
    Click Button    ${Create Button}

Input Post Titel In Post View
    [Arguments]    ${post_title}
    ${inpur_field}=    Set Variable    xpath://*[@class='EditForm__name-field']//*[@name='name']
    Input Text    ${inpur_field}    ${post_title}

Input Post Message In Post View
    [Arguments]    ${post_message}
    ${content_frame} =    Set Variable    xpath:/html/body/div[1]/div/main/div/div/div[1]/form/div[1]/div[1]/div/div[7]/div/div/div/div/div[2]/iframe
    Wait For Element    ${content_frame}
    Select Frame    ${content_frame}
    Wait For Element    tinymce
    Click Element    tinymce
    Input Text    tinymce    ${post_message}
    Unselect Frame

Input Category In Post View
    [Arguments]    ${category}
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    ${category_selector} =    Set Variable    //label[@for='categories']//..//div[@class='FormField__inner field-size-full']//*[@class='Select-arrow']
    Wait For Element    ${category_selector}
    Click Element    ${category_selector}
    ${option} =    Set Variable    xpath://*[@role="option" and text()="${category}"]
    Wait For Element    ${option}
    Click Element    ${option}
    
Input Comment State In Post View
    [Arguments]    ${state}
    ${state_selector} =    Set Variable    //label[@for='state']//..//div[@class='FormField__inner field-size-full']//*[@class='Select-arrow']
    Wait For Element    ${state_selector}
    Click Element    ${state_selector}
    ${option} =    Set Variable    xpath://*[@role="option" and text()="${state}"]
    Wait For Element    ${option}
    Click Element    ${option}

Click Save Post Button In Post View
    ${Save Button} =    Set Variable    xpath://button[@type='button' and normalize-space()='Save']
    Click Button    ${Save Button}

Back To Post List In Post View
    ${Back To Post Button}=    Set Variable    xpath://div[@data-screen-id='item']//a[@href='/keystone/posts']
    Wait For Element    ${Back To Post Button}
    Click Link    ${Back To Post Button}
    Wait For Post List Block

# delete
Click Delete Post Button On Post List
    [Arguments]    ${post name}
    ${Post Delete Button}=    Set Variable    xpath=//td[@class='ItemList__col']//*[normalize-space()='${post name}']//..//preceding-sibling::td//button[contains(@class, 'delete')]
    Wait For Element    ${Post Delete Button}
    Click Button    ${Post Delete Button}

Click Delete Post Button On Delete Post Window
    ${Delete Button}=    Set Variable    xpath=//button[text()="Delete"]
    Wait For Element    ${Delete Button}
    Click Button    ${Delete Button}

Click Cancel Delete Post Button On Delete Post Window
    ${Cancel Button}=    Set Variable    xpath=//button[text()="Cancel"]
    Wait For Element    ${Cancel Button}
    Click Button    ${Cancel Button}

# edit
Select Post On Post List
    [Arguments]    ${post name}
    ${post} =    Set Variable    //td[@class='ItemList__col']//*[normalize-space()='${post name}']
    Click Link    ${post}
    ${body} =    Set Variable    //div[@id='react-root']
    Wait For Element  ${body}

# reuse
Create A Post
    [Arguments]    ${post name}
    Click Craete Post Button
    Input Text    name:name    ${post name}
    Click Craete Post Button In Pop Windows
    Back To Post List In Post View

Create A Post With Title And Message
    [Arguments]    ${post name}    ${post message}
    Click Craete Post Button
    Input Post Title In Pop Windows    ${post name}
    Click Craete Post Button In Pop Windows
    Input Post Message In Post View    ${post message}
    Click Save Post Button In Post View
    Back To Post List In Post View

Remove A Post
    [Arguments]    ${post name}
    ${Post Delete Button}=    Set Variable    xpath=//td[@class='ItemList__col']//*[normalize-space()='${post name}']//..//preceding-sibling::td//button[contains(@class, 'delete')]
    Wait For Element    ${Post Delete Button}
    Click Button    ${Post Delete Button}
    ${Delete Button}=    Set Variable    xpath=//button[text()="Delete"]
    Wait For Element    ${Delete Button}
    Click Button    ${Delete Button}