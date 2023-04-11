import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank {
  stable var currentAmount: Float = 300;
  stable var startTime = Time.now();

  public func getCurrentTime() {
    Debug.print(debug_show(Time.now()))
  };

  public func topUp(amount : Float) {
    currentAmount += amount;
    Debug.print(debug_show (currentAmount));
  };

  public func withdrawAmount(amount : Float) {
    let amountDiff: Float = (currentAmount - amount);

    if (amountDiff <= 0) {
      Debug.print("Not enough amount for transaction!");
    } else {
      currentAmount -= amount;
      Debug.print(debug_show (currentAmount));
    };
  };

  public query func getCurrentAmount(): async Float {
    return currentAmount;
  };

  // compound = PrincipleAmount * (1 + (rateOfInterest / numberOfTimeInterestIsCompounded)) ^ (numberOfTimeInterestIsCompounded * totalTime)
  public func compound() {
    let currentTime = Time.now();
    let timeElapsed = Float.fromInt((currentTime - startTime) / (10 ** 9)); // nanosecond to secon

    currentAmount := (currentAmount * (1.01 ** timeElapsed));
    startTime := currentTime;
  };
};