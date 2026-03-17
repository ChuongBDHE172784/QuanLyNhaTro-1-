// UI-only helpers (no backend dependency).
(function () {
  // Enable Bootstrap tooltips if present.
  document.addEventListener("DOMContentLoaded", function () {
    if (window.bootstrap) {
      document
        .querySelectorAll('[data-bs-toggle="tooltip"]')
        .forEach(function (el) {
          new bootstrap.Tooltip(el);
        });
    }
  });
})();

