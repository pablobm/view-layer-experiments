import Component, { tracked } from '@glimmer/component';

export default class ModelDisplay extends Component {
  @tracked itemList = [];

  @tracked('itemList')
  get buttonText() {
    return this.itemList.length == 0 ? "Populate" : "Refresh";
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
        console.log("UPDATE ACTION RECEIVED");
        this.itemList = payload.model;
      }
    });
  }

  refresh() {
    let msg = {
      origin: 'view',
      target: 'core',
      action: 'refresh',
    }
    window.postMessage(msg, window.location.origin);
  }
};
