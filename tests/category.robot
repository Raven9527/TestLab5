*** Settings ***
Documentation    This is the file where we define the category reuse keywords.
Library          SeleniumLibrary
# Library          Selenium2Library
Resource          resource.robot

*** Keywords ***
# create
Click Craete Category Button 
    ${Create First Post Button}=    Set Variable    xpath://button[contains(text(),'Create')]
    ${Create Other Post Button}=    Set Variable    xpath://button[@title='Create Category']
    ${Is First Time}=    Run Keyword And Return Status    Wait For Element    ${Create First Post Button}
    ${Create Post Button}=    Run Keyword If    ${Is First Time} == True    Set Variable    ${Create First Post Button}
    ...    ELSE    Set Variable    ${Create Other Post Button}
    Wait For Element    ${Create Post Button}
    Click Button   ${Create Post Button}

Input Category Name In Pop Windows
    [Arguments]    ${category name}
    Input Text    name:name    ${category name}
    
Click Craete Category Button In Pop Windows
    ${Create Button} =    Set Variable    xpath://button[text()='Create']
    Click Button    ${Create Button}

# Input Post Titel In Post View
#     [Arguments]    ${post_title}
#     ${inpur_field}=    Set Variable    xpath://*[@class='EditForm__name-field']//*[@name='name']
#     Input Text    ${inpur_field}    ${post_title}

# Input Post Message In Post View
#     [Arguments]    ${post_message}
#     ${content_frame} =    Set Variable    xpath:/html/body/div[1]/div/main/div/div/div[1]/form/div[1]/div[1]/div/div[7]/div/div/div/div/div[2]/iframe
#     Wait For Element    ${content_frame}
#     Select Frame    ${content_frame}
#     Wait For Element    tinymce
#     Click Element    tinymce
#     Input Text    tinymce    ${post_message}
#     Unselect Frame

# Click Save Post Button In Post View
#     ${Save Button} =    Set Variable    xpath://button[@type='button' and normalize-space()='Save']
#     Click Button    ${Save Button}

Back To Category List In Post View
    ${Back To Category Button}=    Set Variable    xpath://div[@data-screen-id='item']//a[@href='/keystone/post-categories']
    Wait For Element    ${Back To Category Button}
    Click Link    ${Back To Category Button}
    Wait For Post List Block

# # delete
# Click Delete Post Button On Post List
#     [Arguments]    ${post name}
#     ${Post Delete Button}=    Set Variable    xpath=//td[@class='ItemList__col']//*[normalize-space()='${post name}']//..//preceding-sibling::td//button[contains(@class, 'delete')]
#     Wait For Element    ${Post Delete Button}
#     Click Button    ${Post Delete Button}

# Click Delete Post Button On Delete Post Window
#     ${Delete Button}=    Set Variable    xpath=//button[text()="Delete"]
#     Wait For Element    ${Delete Button}
#     Click Button    ${Delete Button}

# Click Cancel Delete Post Button On Delete Post Window
#     ${Cancel Button}=    Set Variable    xpath=//button[text()="Cancel"]
#     Wait For Element    ${Cancel Button}
#     Click Button    ${Cancel Button}

# # edit
# Select Post On Post List
#     [Arguments]    ${post name}
#     ${post} =    Set Variable    //td[@class='ItemList__col']//*[normalize-space()='${post name}']
#     Click Link    ${post}
#     ${body} =    Set Variable    //div[@id='react-root']
#     Wait For Element  ${body}

# # reuse
Create A Category
    [Arguments]    ${name}
    Click Craete Category Button
    Input Category Name In Pop Windows    ${name}
    Click Craete Category Button In Pop Windows
    Back To Category List In Post View

# Create A Post With Title And Message
#     [Arguments]    ${post name}    ${post message}
#     Click Craete Post Button
#     Input Post Title In Pop Windows    ${post name}
#     Click Craete Post Button In Pop Windows
#     Input Post Message In Post View    ${post message}
#     Click Save Post Button In Post View
#     Back To Post List In Post View

Remove A Category
    [Arguments]    ${category name}
    ${Category Delete Button}=    Set Variable    xpath=//td[@class='ItemList__col']//*[normalize-space()='${category name}']//..//preceding-sibling::td//button[contains(@class, 'delete')]
    Wait For Element    ${Category Delete Button}
    Click Button    ${Category Delete Button}
    ${Delete Button}=    Set Variable    xpath=//button[text()="Delete"]
    Wait For Element    ${Delete Button}
    Click Button    ${Delete Button}