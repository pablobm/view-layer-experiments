import Component, { tracked } from '@glimmer/component';

export default class ModelDisplay extends Component {
  @tracked itemList = [];

  @tracked('itemList')
  get buttonText() {
    return this.itemList.length == 0 ? "Populate" : "Refresh";
  }

  refresh() {
    let msg = {
      origin: 'view',
      target: 'core',
      action: 'refresh',
    }
    window.postMessage(msg, '*');
  }
};
