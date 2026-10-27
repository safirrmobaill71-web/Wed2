
const languageToggle = document.getElementById("languageToggle");
const menuToggle = document.getElementById("menuToggle");
const nav = document.getElementById("nav");
const cartCount = document.getElementById("cartCount");
const toast = document.getElementById("toast");

let currentLanguage = "fa";
let cartItems = 0;
let toastTimer;

document.getElementById("year").textContent =
  new Date().getFullYear();

// Change language
function setLanguage(language) {
  currentLanguage = language;

  document.documentElement.lang = language;
  document.documentElement.dir =
    language === "fa" ? "rtl" : "ltr";

  document.querySelectorAll("[data-fa][data-en]").forEach(element => {
    element.textContent = element.dataset[language];
  });

  languageToggle.textContent =
    language === "fa" ? "FA / EN" : "EN / FA";

  menuToggle.setAttribute(
    "aria-label",
    language === "fa" ? "باز کردن منو" : "Open menu"
  );

  document.title =
    language === "fa"
      ? "Lumière | فروشگاه عطر و ادکلن"
      : "Lumière | Perfume & Fragrance";

  closeMenu();
}

languageToggle.addEventListener("click", () => {
  setLanguage(currentLanguage === "fa" ? "en" : "fa");
});

// Mobile menu
menuToggle.addEventListener("click", () => {
  const isOpen = nav.classList.toggle("open");

  menuToggle.setAttribute("aria-expanded", String(isOpen));
});

function closeMenu() {
  nav.classList.remove("open");
  menuToggle.setAttribute("aria-expanded", "false");
}

nav.querySelectorAll("a").forEach(link => {
  link.addEventListener("click", closeMenu);
});

// Shopping cart demo
function showToast(message) {
  clearTimeout(toastTimer);

  toast.textContent = message;
  toast.classList.add("show");

  toastTimer = setTimeout(() => {
    toast.classList.remove("show");
  }, 2500);
}

document.querySelectorAll(".buy-btn").forEach(button => {
  button.addEventListener("click", () => {
    cartItems++;
    cartCount.textContent = cartItems;

    const productName =
      button.closest(".product-card").querySelector("h3").textContent;

    const message =
      currentLanguage === "fa"
        ? `${productName} به سبد خرید اضافه شد.`
        : `${productName} added to your cart.`;

    showToast(message);
  });
});

// Initial state
setLanguage("fa");
