*** Settings ***
Documentation    This is the file where we define the comment reuse keywords.
Library          SeleniumLibrary
# Library          Selenium2Library
Resource          resource.robot

*** Keywords ***
Click Craete Comment Button 
    ${Create First Post Button}=    Set Variable    xpath://button[contains(text(),'Create')]
    ${Create Other Post Button}=    Set Variable    xpath://button[@title='Create Comment']
    ${Is First Time}=    Run Keyword And Return Status    Wait For Element    ${Create First Post Button}
    ${Create Post Button} =    Run Keyword If    ${Is First Time} == True    Set Variable    ${Create First Post Button}
    ...    ELSE    Set Variable    ${Create Other Post Button}
    Wait For Element    ${Create Post Button}
    Click Button   ${Create Post Button}

Input Comment Author In Pop Windows
    [Arguments]    ${author}
    IF    $author is not None
        ${author_selector} =    Set Variable    css:* > div.Select-control
        Wait For Element    ${author_selector}
        Click Element    ${author_selector}
        ${option} =    Set Variable    xpath://*[@role="option" and text()="${author}"]
        Wait For Element    ${option}
        Click Element    ${option}
    END
    
Input Comment Post In Pop Windows
    [Arguments]    ${post}
    IF    $post is not None
        ${post_selector}=    Set Variable    xpath:/html/body/div[2]/div/div/div/div/form/div[2]/div[2]/div/div/div/div
        Wait For Element    ${post_selector}
        Click Element    ${post_selector}
        ${option}=    Set Variable    xpath://*[@role="option" and text()="${post}"]
        Wait For Element    ${option}
        Click Element    ${option}
    END
    
Click Craete Comment Button In Pop Windows
    ${Create Button} =    Set Variable    xpath://button[text()='Create']
    Click Button    ${Create Button}

# not done
Exit Pop Winodws
    ${windows} =    Set Variable    //*[@data-screen-id='modal-dialog']
    ${cancel_button} =    Set Variable    //button[@data-button-type='cancel' and normalize-space()='Cancel']
    Click Button    ${cancel_button}
    Wait Until Element Not Exist  ${windows}

# not done
Input Comment Author In Comment View
    [Arguments]    ${post_title}
    ${inpur_field}=    Set Variable    xpath://*[@class='EditForm__name-field']//*[@name='name']
    Input Text    ${inpur_field}    ${post_title}

# not done
Input Comment Post In Comment View
    [Arguments]    ${post_message}
    ${content_frame} =    Set Variable    xpath:/html/body/div[1]/div/main/div/div/div[1]/form/div[1]/div[1]/div/div[7]/div/div/div/div/div[2]/iframe
    Wait For Element    ${content_frame}
    Select Frame    ${content_frame}
    Wait For Element    tinymce
    Click Element    tinymce
    Input Text    tinymce    ${post_message}
    Unselect Frame

Click Save Comment Button In Comment View
    ${Save Button} =    Set Variable    xpath://button[@type='button' and normalize-space()='Save']
    Click Button    ${Save Button}

Back To Comment List In Comment View
    ${Back To Comment Button}=    Set Variable    xpath://div[@data-screen-id='item']//a[@href='/keystone/post-comments']
    Wait For Element    ${Back To Comment Button}
    Click Link    ${Back To Comment Button}
    Wait For Feature List Block

Get Comment ID
    ${id_field} =    Set Variable    //div[@class='EditForm__name-field']
    ${id} =    Get Text    ${id_field}
    [Return]    ${id}

Remove A Comment
    [Arguments]    ${id}
    ${Comment Delete Button}=    Set Variable    xpath=//td[@class='ItemList__col']//*[normalize-space()='${id}']//..//preceding-sibling::td//button[contains(@class, 'delete')]
    Wait For Element    ${Comment Delete Button}
    Click Button    ${Comment Delete Button}
    ${Delete Button}=    Set Variable    xpath=//button[text()="Delete"]
    Wait For Element    ${Delete Button}
    Click Button    ${Delete Button}