window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const addTax = document.getElementById("add-tax-price");
    addTax.innerHTML = Math.round(priceInput.value * 0.1);
    const addProfit = document.getElementById("profit");
    addProfit.innerHTML = Math.round(priceInput.value - Math.round(priceInput.value * 0.1));
  })
});
