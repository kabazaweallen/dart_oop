// Encapsulation
class BankAccount {
  // Private variable
  double _balance;

  BankAccount(this._balance);

  // Method to deposit money
  void deposit(double amount) {
    if (amount > 0) {
      _balance += amount;
    }
  }

  // Method to withdraw money
  void withdraw(double amount) {
    if (amount > 0 && amount <= _balance) {
      _balance -= amount;
    }
  }

  // Controlled access to balance
  double get balance => _balance;
}

// Inheritance
class SavingsAccount extends BankAccount {
  double interestRate;

  SavingsAccount(double balance, this.interestRate) : super(balance);

  void applyInterest() {
    double interest = balance * interestRate;
    deposit(interest);
  }
}

// Polymorphism
class CheckingAccount extends BankAccount {
  CheckingAccount(double balance) : super(balance);

  @override
  void withdraw(double amount) {
    // Allow overdraft for checking accounts
    if (amount > 0) {
      _balance -= amount; // Can go below zero
    }
  }
}

// Abstraction
abstract class Transaction {
  void execute();
}

class DepositTransaction extends Transaction {
  BankAccount account;
  double amount;

  DepositTransaction(this.account, this.amount);

  @override
  void execute() {
    account.deposit(amount);
    print('Deposited: \frw${amount}');
  }
}

class WithdrawTransaction extends Transaction {
  BankAccount account;
  double amount;

  WithdrawTransaction(this.account, this.amount);

  @override
  void execute() {
    account.withdraw(amount);
    print('Withdrew: \frw${amount}');
  }
}

void main() {
  // Encapsulation
  var savings = SavingsAccount(1000, 0.05);
  savings.deposit(500);
  savings.applyInterest();
  print('Savings Account Balance: \frw${savings.balance}');

  var checking = CheckingAccount(500);
  checking.withdraw(600); // Overdraft
  print('Checking Account Balance: \frw${checking.balance}');

  // Abstraction
  Transaction deposit = DepositTransaction(savings, 200);
  deposit.execute();
  
  Transaction withdraw = WithdrawTransaction(checking, 100);
  withdraw.execute();
  
  print('Final Savings Account Balance: \frw${savings.balance}');
  print('Final Checking Account Balance: \frw${checking.balance}');
}
