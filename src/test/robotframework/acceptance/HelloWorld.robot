*** Settings ***
Documentation     Simple example using SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
${URL}      https://www.google.ca
@{CHROME_ARGUMENTS}    --disable-infobars    --headless    --disable-gpu
${BROWSER}        Chrome
${TIMEOUT}        10s

*** Test Cases ***
Valid Title
    [Documentation]    Sample Test For Chrome Headless
    [Tags]    chrome    headless
    Open Browser Hello World
    [Teardown]    Close Browser

*** Keywords ***
Open Browser Hello World
    ${chrome_options}=    Set Chrome Options
    Create Webdriver    ${BROWSER}    chrome_options=${chrome_options}
    Go To    ${URL}
    Title Should Be    Google    ${timeout}
    Capture Page Screenshot
    [Teardown]    Close Browser
    
Set Chrome Options
    [Documentation]    Set Chrome options for headless mode
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    : FOR    ${option}    IN    @{CHROME_ARGUMENTS}
    \    Call Method    ${options}    add_argument    ${option}
    [Return]    ${options}