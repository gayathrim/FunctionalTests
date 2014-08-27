
1. Runs with ruby 1.9.3 and above
2. Do 'bundle install' from ProductsFunctionalTests folder
3. 'rake share_feature' will run the share by email feature tests.
4. Output folder has screenshots and report.html file
5. On multiple test runs, amazon starts showing captcha images, which is not handled. In such cases, register new user in amazon and use the same.

Defect found in Amazon share email feature:

Amazon sends different product sku in the plain text version of email. However, the sku is not totally different, in some cases the new sku shows all
product attributes to be exactly same as the original. But in others there are differences.

The tests are currently reading the text version of email and hence will fail.


