// Entry point for the build script in your package.json
import "./vendor.min.js";
import "./gr-theme-mode-switcher.js"
import "./custom.js";
import AOS from 'aos';
import 'aos/dist/aos.css';
document.addEventListener('DOMContentLoaded', () => {
  AOS.init({
    duration: 400, // or customize
    easing: 'ease',
    once: true
  });
});


import $ from "jquery";
window.jQuery = $;
window.$ = $;
