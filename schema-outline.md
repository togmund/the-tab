# Schema Outline

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
- Total

## Entries

- ID
- Receipt_ID
- Member_ID
- Amount_Paid
- Share

IF Share(Total Bill / Count of Transactions - Amount Paid) = Change in Debt/Credit

Total Debt/Credit = Sum of all changes

Always calculated? Never stored?
