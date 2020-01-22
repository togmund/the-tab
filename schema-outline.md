# Schema Outline

Group <-- Members --> Users || Receipts --> Transactions
^----------------------|

A Group can have many users
A user can be in many groups by way of membership

A user can have many transcations
A transaction can have many users

## Groups

- ID
- Name

## Members

- ID
- Group_ID
- User_ID

## Users

- ID
- Name

## Receipts

- ID
- Tag
- Total Bill

## Lines

- ID
- Member_ID
- Amount Paid

Total Bill / Count of Transactions - Amount Paid = Change in Debt/Credit

Total Debt/Credit = Sum of all changes

Always calculated? Never stored?
