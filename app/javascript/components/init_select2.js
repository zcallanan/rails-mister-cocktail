// app/javascript/components/init_select2.js
import $ from 'jquery';
import 'select2';
import "select2/dist/css/select2.css";

const initSelect2 = () => {
  $('.select2').select2();
};

export { initSelect2 };
