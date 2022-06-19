*** Settings ***
Documentation    This is the file where we define the enquire reuse keywords.
Library          SeleniumLibrary
# Library          Selenium2Library
Resource          resource.robot

*** Keywords ***
Click Submit On Contact Page
    ${button} =    Set Variable    //*[@type='submit']
    Wait For Element    ${button}
    Click Element    ${button}

Input Enquire Information On Contact Page
    [Arguments]    ${name}    ${email}    ${phone}    ${regarding}    ${message}
    Input Enquire Name On Contact Page    ${name}
    Input Enquire Email On Contact Page    ${email}
    Input Enquire Phone On Contact Page    ${phone}
    Input Enquire Regarding On Contact Page    ${regarding}
    Input Enquire Message On Contact Page    ${message}
    Click Submit On Contact Page

Input Enquire Name On Contact Page
    [Arguments]    ${name}
    ${input_field} =    Set Variable    //input[@name='name.full']
    Wait For Element    ${input_field}
    Input Text    ${input_field}    ${name}

Input Enquire Email On Contact Page
    [Arguments]    ${email}
    ${input_field} =    Set Variable    //input[@name='email']
    Wait For Element    ${input_field}
    Input Text    ${input_field}    ${email}

Input Enquire Phone On Contact Page
    [Arguments]    ${phone}
    ${input_field} =    Set Variable    //input[@name='phone']
    Wait For Element    ${input_field}
    Input Text    ${input_field}    ${phone}

Input Enquire Regarding On Contact Page
    [Arguments]    ${regarding}
    ${input_field} =    Set Variable    //select[@name='enquiryType']
    Wait For Element    ${input_field}
    Click Element    ${input_field}
    ${option} =    Set Variable    xpath://*[contains(text(), '${regarding}')]
    Wait For Element    ${option}
    Click Element    ${option}

Input Enquire Message On Contact Page
    [Arguments]    ${message}
    ${input_field} =    Set Variable    //textarea[@name='message']
    Wait For Element    ${input_field}
    Input Text    ${input_field}    ${message}

Go To Admin UI After Create Enquire
    ${link} =    Set Variable    //*[@href='/keystone/enquiries']
    Wait For Element    ${link}
    Click Element    ${link}
    ${block} =    Set Variable    //div[@data-screen-id='list']//h2[contains(normalize-space(), 'Enquir')]
    Wait For Element    ${block}

Click Delete Enquire Button On Enquire List
    [Arguments]    ${name}
    ${Enquire Delete Button}=    Set Variable    xpath=//td[@class='ItemList__col']//*[normalize-space()='${name}']//..//preceding-sibling::td//button[contains(@class, 'delete')]
    Wait For Element    ${Enquire Delete Button}
    Click Button    ${Enquire Delete Button}

Click Delete Button On Delete Enquire Pop Window
    ${Delete Button}=    Set Variable    xpath=//button[text()="Delete"]
    Wait For Element    ${Delete Button}
    Click Button    ${Delete Button}

Click Cancel Button On Delete Enquire Pop Window
    ${Cancel Button}=    Set Variable    xpath=//button[text()="Cancel"]
    Wait For Element    ${Cancel Button}
    Click Button    ${Cancel Button}

Wait For Create Enquire Success
    ${block} =    Set Variable    //div[@class='jumbotron text-center']//*[normalize-space()='Success!']
    Wait For Element    ${block}

Remove A Enquire
    [Arguments]    ${name}
    ${Enquire Delete Button}=    Set Variable    xpath=//td[@class='ItemList__col']//*[normalize-space()='${name}']//..//preceding-sibling::td//button[contains(@class, 'delete')]
    Wait For Element    ${Enquire Delete Button}
    Click Button    ${Enquire Delete Button}
    ${Delete Button}=    Set Variable    xpath=//button[text()="Delete"]
    Wait For Element    ${Delete Button}
    Click Button    ${Delete Button}