Feature: ATM withdraw
 
Scenario Outline: "<case>"
  Given my account balance is "<balance>"
  And the ATM contains "<ATM_balance>"
  When I withdraw "<withdraw>"
  Then I get "<message>" message

  Examples:
    | case                                     | balance | ATM_balance | withdraw | message                               |
    | Account has sufficient funds             | 500     | 600         | 50       | Take your money!                      |
    | Account has insufficient funds           | 500     | 600         | 550      | You don't have enough money!          |
    | The ATM has insufficient amount of money | 500     | 150         | 300      | The machine is not have enough money! |
    