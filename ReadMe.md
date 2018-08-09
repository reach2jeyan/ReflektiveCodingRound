**Reflektive Coding Round**

Note:

Sorry! but, Due to time constraints with my current projects in my organization with releases schedules, I have not taken care of the way the code needs to be structured. However, the functionality that the assignment demanded has been taken care of.

**About Framework:**

Cucumber Framework is used to automate the assignment. The Engine for it is written in Ruby using watir which is again a wrapper of selenium. 


**Prerequisites:**

1. Please install chromedriver from chrome and geckodriver for firefox if you want to run on the respective browsers.
2. Install all the gems mentioned in the gemfile and do a bundle install to install its dependencies. The gems are not locked for a particular version.

**How do I run?**
Navigate to the project folder inside the folder Reflektive in the terminal
1. If you want to run on chrome, use the command
`cucumber BROWSER=chrome --format json --out chrome.json --format pretty  -f rerun --out rerun.txt || cucumber @rerun.txt`
2. If you want to run on firefox, use the command
`BROWSER=chrome --format json --out firefox.json --format pretty  -f rerun --out rerun.txt || cucumber @rerun.txt')
`
3. If you want to run on both browsers parallely, run the command
`rake all`

Currently, I have just done for the above browsers


**Artifacts:**
1. Report at the end of the test will be created in the project + browsername. In case of parallel test, two reports are created seperately in the naming convention mentioned.
2. Expenditure details is logged in terminal and also generated in `.text` format
3. Screenshots in case of failure are handled in the reports. The screenshot will be embedded in the report.html

