import Component, { tracked } from '@glimmer/component';

export default class ModelDisplay extends Component {
  @tracked model = null;

  increment() {
    this.postIncrement(1);
  }

  decrement() {
    this.postIncrement(-1);
  }

  reset() {
    let msg = {
      origin: 'view',
      target: 'core',
      action: 'reset',
    }
    window.postMessage(msg, window.location.origin);
  }

  postIncrement(amount) {
    let msg = {
      origin: 'view',
      target: 'core',
      action: 'increment',
      payload: { amount },
    }
    window.postMessage(msg, window.location.origin);
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
