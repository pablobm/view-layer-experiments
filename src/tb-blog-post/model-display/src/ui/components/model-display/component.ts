import Component, { tracked } from '@glimmer/component';

export default class ModelDisplay extends Component {
  @tracked model = null;

  increment() {
    console.log("Increment");
  }

  decrement() {
    console.log("Decrement");
  }

  didInsertElement() {
    window.addEventListener('message', (evt) => {
      if (evt.origin !== window.location.origin) {
        return false;
      }

      let data = evt.data;
      if (data.origin !== 'core' && data.target !== 'view') {
        return false;
      }

      let { action, payload } = data;
      if (action === 'update') {
        this.model = payload.model;
      }
    });
  }
}
