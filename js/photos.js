---
---
{% assign images = site.static_files | photo_filter %}
(function(html) {
  const photo = document.currentScript.getAttribute('data-photo-id');
  const target = document.currentScript.getAttribute('data-target-id');
  const container = document.querySelector(`#${target}`);
  container.innerHTML = html;
  document.querySelector(`#${photo}`).classList.add(TARGET_CLASS);
  lazyload();
})(`{% include photos.html %}`);
