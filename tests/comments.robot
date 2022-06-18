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
    Wait For Element  ${id_field}
    ${id} =    Get Text    ${id_field}
    [Return]    ${id}

Click Delele Comment Button On Comment List
    [Arguments]    ${id}
    ${Comment Delete Button}=    Set Variable    xpath=//td[@class='ItemList__col']//*[normalize-space()='${id}']//..//preceding-sibling::td//button[contains(@class, 'delete')]
    Wait For Element    ${Comment Delete Button}
    Click Button    ${Comment Delete Button}

Click Delete Button On Delete Comment Pop Windows
    ${Delete Button}=    Set Variable    xpath=//button[text()="Delete"]
    Wait For Element    ${Delete Button}
    Click Button    ${Delete Button}

Click Cancel Button On Delete Comment Pop Windows
    ${Cancel Button}=    Set Variable    xpath=//button[text()="Cancel"]
    Wait For Element    ${Cancel Button}
    Click Button    ${Cancel Button}

# edit
Select Comment On Comment List
    [Arguments]    ${id}
    ${comment} =    Set Variable    //*[normalize-space()='${id}']
    Wait For Element  ${comment}
    Click Element    ${comment}
    ${block} =   Set Variable    //div[@class='EditForm__name-field']
    Wait For Element    ${block}

Input Comment Author In Comment View
    [Arguments]    ${author}
    ${clear_button}=    Set Variable    xpath://label[@for='author']//..//div[@class='FormField__inner field-size-full']//*[@class='Select-clear']
    ${have_button}=    Run Keyword And Return Status    Wait For Element By Time    ${clear_button}    1   
    Run Keyword If    ${have_button} == True    Click Element    ${clear_button}
    IF    $author is not None
        ${author_selector} =    Set Variable    //label[@for='author']//..//div[@class='FormField__inner field-size-full']//*[@class='Select-arrow']
        Wait For Element    ${author_selector}
        Click Element    ${author_selector}
        ${option} =    Set Variable    xpath://*[@role="option" and text()="${author}"]
        Wait For Element    ${option}
        Click Element    ${option}
    END

Input Comment Post In Comment View
    [Arguments]    ${post}
    ${clear_button}=    Set Variable    xpath://label[@for='post']//..//div[@class='FormField__inner field-size-full']//*[@class='Select-clear']
    ${have_button}=    Run Keyword And Return Status    Wait For Element By Time    ${clear_button}    1   
    Run Keyword If    ${have_button} == True    Click Element    ${clear_button}
    IF    $post is not None
        ${post_selector} =    Set Variable    //label[@for='post']//..//div[@class='FormField__inner field-size-full']//*[@class='Select-arrow']
        Wait For Element    ${post_selector}
        Click Element    ${post_selector}
        ${option} =    Set Variable    xpath://*[@role="option" and text()="${post}"]
        Wait For Element    ${option}
        Click Element    ${option}
    END

Input Comment State In Comment View
    [Arguments]    ${state}
    IF    $state is not None
        ${state_selector} =    Set Variable    //label[@for='commentState']//..//div[@class='FormField__inner field-size-full']//*[@class='Select-arrow']
        Wait For Element    ${state_selector}
        Click Element    ${state_selector}
        ${option} =    Set Variable    xpath://*[@role="option" and text()="${state}"]
        Wait For Element    ${option}
        Click Element    ${option}
    END

Input Comment Content In Comment View
    [Arguments]    ${message}
    ${content_frame} =    Set Variable    xpath:/html/body/div[1]/div/main/div/div/div[1]/form/div[1]/div[1]/div/div[6]/div/div/div/div/div[2]/iframe
    Wait For Element    ${content_frame}
    Select Frame    ${content_frame}
    Wait For Element    tinymce
    Click Element    tinymce
    Input Text    tinymce    ${message}
    Unselect Frame

Input Comment Information In Comment View
    [Arguments]    ${author}    ${post}    ${state}    ${message}
    Input Comment Author In Comment View    ${author}
    Input Comment Post In Comment View    ${post}
    Input Comment State In Comment View    ${state}
    Input Comment Content In Comment View    ${message}

Save Comment Button On Comment View
    ${Save Button} =    Set Variable    xpath://button[@type='button' and normalize-space()='Save']
    Click Button    ${Save Button}

Reset Change Button On Comment View
    ${reset Button} =    Set Variable    xpath://button[@type='button' and normalize-space()='reset changes']
    Click Button    ${reset Button}

    ${confirm Button} =    Set Variable    xpath://button[@type='button' and @data-button-type='confirm']
    Wait For Element    ${confirm Button}

    Click Button    ${confirm Button}

Create A Comment
    [Arguments]    ${author}    ${post}
    ${count} =    Get Feature Count
    Click Craete Comment Button
    Input Comment Author In Pop Windows    ${author}
    Input Comment Post In Pop Windows    ${post}
    Click Craete Comment Button In Pop Windows
    ${comment_id} =    Get Comment ID
    Back To Comment List In Comment View
    [Return]    ${comment_id}

Remove A Comment
    [Arguments]    ${id}
    ${Comment Delete Button}=    Set Variable    xpath=//td[@class='ItemList__col']//*[normalize-space()='${id}']//..//preceding-sibling::td//button[contains(@class, 'delete')]
    Wait For Element    ${Comment Delete Button}
    Click Button    ${Comment Delete Button}
    ${Delete Button}=    Set Variable    xpath=//button[text()="Delete"]
    Wait For Element    ${Delete Button}
    Click Button    ${Delete Button}