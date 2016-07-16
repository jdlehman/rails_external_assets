import './index.scss';
import hexToRgb from 'hex-to-rgb';
import uuid from 'node-uuid';

export default class ColorConverter {
  constructor(name, nodeId) {
    this.node = document.getElementById(nodeId);
    this.name = name;
    this.render();
  }

  render() {
    const uid = uuid.v4();
    this.node.innerHTML = `
      <div class="color-converter">
        <h1>${this.name}</h1>
        <input id="${uid}-input" class="color-converter__hex" type="text" placeHolder="Hex Color (#000000)" />
        <div class="color-converter__rgb">
          <span id="${uid}-rgb" class="color-converter__rgb__name"></span>
          <span id="${uid}-color" class="color-converter__rgb__color-block"></span>
        </div>
      </div>
    `;
    const inputNode = document.getElementById(`${uid}-input`);
    const rgbNode = document.getElementById(`${uid}-rgb`);
    const colorNode = document.getElementById(`${uid}-color`);

    inputNode.addEventListener('input', function({target: {value}}) {
      if (value.length > 0) {
        const rgb = hexToRgb(value);
        rgbNode.innerHTML = `RGB: (${rgb})`;
        colorNode.style.backgroundColor = `rgb(${rgb})`;
        colorNode.classList.add('is-shown');
      } else {
        rgbNode.innerHTML = '';
        colorNode.classList.remove('is-shown');
      }
    });
  }
}
