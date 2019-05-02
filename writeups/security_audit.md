#Security Audit



###SQL Injection



How to avoid SQL injection given our write-in option. Although we currently are using a YAML file to store our votes we are planning to migrate to a proper database and our write-in option will leave us vulnerable to a SQL injection.
In Sinatra, the best way to avoid unsafe user input is to use parameterization and/or sanitization. For example, without parametrization and/or sanitization you could input:
```
params[:id] = "1) OR 1=1--"
User.delete_all("id = #{params[:id]}")
```
And this SQL query will delete all the users. Parametrization queries will get rid of the ‘dirty’ code for us via proper substitution of arguments i.e. if the input contains SQL it will not run this is not a perfect solution but given that we are not sending our results to other places it will serve our purposes.
####Sanitization code:
```
/([--])|([;])/.match(params[:id]) ? run-q(params[:id]) : erb :error
https://github.com/OWASP/CheatSheetSeries/blob/master/cheatsheets/Query_Parameterization_Cheat_Sheet.md
```



###General Issue
We do not have a login service and much like SurveyMonkey, at least thus far, our voting system is based on people having received the URL. However, we are not logging users when they vote which will result in people able to vote infinitely. A way to avoid this would be to take the IP of the people who have voted previously and then log them into a user database that works in the opposite way that we have typically used a user database in that it will not allow those ‘logged on’ to vote again. You can use a VPN to get around this so we will also think of another way to do it. Alternatively, if you know which group you are sending the voting system to, such as PA, then you could use the logins already used in that system and piggyback off their database of users and not allow that user back in after voting.



###XSS: Cross Site Scripting
We will not be putting any of the data into HTML so this is a non-issue despite the fact that it may appear to be one. Since we only have one input and we already sanitizing and parametrizing it we will not have to deal with this issue.



Overall because of the **simplicity** of the app, there are not many security vulnerabilities. Given that there is only one input this is the sole source of potential problems, which we have addressed as stated above.
