# IMPORTANT
First step, **please fork this repo** and frequently commit as there will be hard stop at 120 minutes and what ever code is committed before the 120th minute will only be considered for evaluation.

# KB
Implement a GIFT VOUCHER SYSTEM in IOS to send Vouchers/coupons as gift to friends or family 

1. Screen A : Login with CREDENTIALS (dummy LOGIN but valudate with JSON and/or SQLlite )
2. Screen B : Home page should welcome the user with greetings along with menu bar to recipient by phone or email and add personlized message ( **should load default phone contacts for both phone number and email from phone directory** with an other option to select different recipient manually, once user is selected navigate to Screen C) 
3. Screen C : Select predefined amount cards/widgets, or enter amount manually or choose predefined coupons/voucher ( define datastructure as JSON for coupon/voucher list) that needs to be sent as voucher, upon selection depending on the above three types of coupons should navigate to Payments page to redeem wallet points or payment by credit or other means
4. Screen D : Payment gateway either by rewards or banking or CC or wallet ( can be simulated with default app wallet ), upon successful payment should navigate to transaction screen E
4. Screen E : Succesfull Transaction Details with unique voucher bar code to be generated and persisted locally ( Screen should contain share button upon click it should share with the person from screen B (phone contact) with a voucher widget by SMS or Whatsapp or FB messenger or email )

On All screen there should be common menu bar/floating button to navigate between screen and other screens like profile , rewards,wallet, log out etc. 

you can use AirAsia Logo for branding.

# IMP Tips:
1. Proper README or SOLUTION guide to run your code to be present
2. All above screens should be implemented
3. Stop developing 15 minutes before the time limit to ensure that it is properly committed to your GIT
4. Leverage the JSON for predefined coupons
5. MVC/MVVM/MVP pattern is a must
6. Production ready code
7. TDD
8. Good Technical design and Creative UX
9. Get Creative in developing the data structure where ever necessary and host it locally in DB or cloud.


You have 120 minutes to finish this. All the Best!!!

