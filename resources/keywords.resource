*** Settings ***
Library    RequestsLibrary
Library    Collections
Variables    ../environment.py
Variables    ../PageObjects/apivariables.py


*** Keywords ***

Create Sessions
    Create Session    mysession    ${BASE_URL}