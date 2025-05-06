// Entry point for the build script in your package.json
import "./vendor.min.js";
import "./gr-theme-mode-switcher.js"
import "./custom.js";
import AOS from 'aos';
import 'aos/dist/aos.css';
AOS.init();
import $ from "jquery";
window.jQuery = $;
window.$ = $;
