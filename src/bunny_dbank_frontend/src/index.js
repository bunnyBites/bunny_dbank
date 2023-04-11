import { bunny_dbank_backend } from "../../declarations/bunny_dbank_backend";

const fetchCurrentAmount = async () => {
  const currentAmount = await bunny_dbank_backend.getCurrentAmount();

  document.getElementById("value").innerHTML = currentAmount.toFixed(2);
};

window.addEventListener("load", fetchCurrentAmount);

document.querySelector("form").addEventListener("submit", async (e) => {
  e.preventDefault();
  const submitBtn = e.target.querySelector("#submit-btn");

  const amountToTopUpInput = document.getElementById("input-amount");
  const withdrawAmountInput = document.getElementById("withdrawal-amount");

  submitBtn.setAttribute("disabled", true);

  if (!!amountToTopUpInput.value) {
    await bunny_dbank_backend.topUp(Number.parseFloat(amountToTopUpInput.value));
  }

  if (!!withdrawAmountInput.value) {
    await bunny_dbank_backend.withdrawAmount(Number.parseFloat(withdrawAmountInput.value));
  }

  await bunny_dbank_backend.compound();

  fetchCurrentAmount();
  amountToTopUpInput.value = "";
  withdrawAmountInput.value = "";

  submitBtn.removeAttribute("disabled");

  return false;
});