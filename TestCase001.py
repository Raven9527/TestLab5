import unittest
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
import TestCaseKeyword as lib

# Verify that if the exception handling is functioning correctly when using invalid title
def verify_exception_if_title_is_null(driver, title):
    if (title == ""):
        hint = "Name is required"
        div = driver.find_element(By.XPATH, "//div[@data-alert-type='danger']/div")
        lib.verify_element_exist(div)
        assert div.text == hint
        return False
    return True

# Verify that if the hint message show in header when save post successfully.
def verify_success_hint_after_save_post(driver):
    sccess_hint = "Your changes have been saved successfully"
    div = driver.find_element(By.XPATH, "//div[@data-alert-type='success']")
    lib.verify_element_exist(div)
    assert div.text == sccess_hint

# Verify that if a new post is created successfully when using valid $title and $message
def verify_there_have_a_new_post_in_post_view(driver, title):
    if (str.isspace(title)):
        title = ""
    title.rstrip()
    locator = f"//td[@class='ItemList__col']//*[normalize-space()='{title}']"
    cells = driver.find_elements(By.XPATH, locator)
    lib.verify_element_exist(cells)
    assert len(cells) > 0
    cell = cells[-1]
    assert cell.text == title

class TestData:
    def __init__(self, title, message):
        self.title = title
        self.message = message

class TestCase001(lib.TestCase):
    
    def __init__(self):
        self.is_success = False
    
    def set_test_data(self, title, message):
        self.title = title
        self.message = message
    
    def set_up(self):
        super().set_up()
        lib.pause_some_second(1)
    
    def test_step(self):
        lib.select_post_feature_on_admin_ui(self.driver)
        lib.click_create_post_button(self.driver)
        lib.enter_post_title(self.driver, self.title)
        lib.click_create_button_in_create_post_pop_window(self.driver)
        self.is_success = verify_exception_if_title_is_null(self.driver, self.title) # Verify that if the exception handling is functioning correctly when using invalid title
        if self.is_success:
            lib.enter_post_messge_in_content_brief(self.driver, self.message)
            lib.click_save_post_button(self.driver)
            verify_exception_if_title_is_null(self.driver, self.title) # Verify that if the exception handling is functioning correctly when using invalid $title or invalid $message
            verify_success_hint_after_save_post(self.driver) # Verify that if the hint message show in header when save post successfully.
            lib.select_post_in_header(self.driver)
            verify_there_have_a_new_post_in_post_view(self.driver, self.title) # Verify that if a new post is created successfully when using valid $title and $message
        else:
            lib.click_cancel_button_in_create_post_pop_window(self.driver)
            
    def tear_down(self):
        if (self.is_success):
            lib.delete_post(self.driver, self.title)
        super().tear_down()

class TestSuite001(unittest.TestCase):
    
    def test_case_1(self):
        case001 = TestCase001()
        case001.set_test_data("", "")
        case001.run()
        
    def test_case_2(self):
        case001 = TestCase001()
        case001.set_test_data(" ", " ")
        case001.run()
        
    def test_case_3(self):
        case001 = TestCase001()
        case001.set_test_data("test123", "test123")
        case001.run()
        
    def test_case_4(self):
        case001 = TestCase001()
        case001.set_test_data("test123!@#$%^", "test123!@#$%^")
        case001.run()
        
    def test_case_5(self):
        case001 = TestCase001()
        case001.set_test_data("!#@ !~~E", "!#@ !~~E")
        case001.run()

if __name__ == "__main__":
    unittest.main()