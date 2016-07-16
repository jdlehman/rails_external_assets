import ColorConverter from './index';

function createColorConverter(name, id) {
  new ColorConverter(name, id);
}

window.createColorConverter = createColorConverter;
