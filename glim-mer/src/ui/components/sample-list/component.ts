import Component, { tracked } from '@glimmer/component';

export default class SampleList extends Component {
  @tracked itemList = [];

  @tracked('itemList')
  get buttonText() {
    return this.itemList.length == 0 ? "Populate" : "Refresh";
  }

  refresh() {
    let newList = []
    if (this.itemList.length == 0) {
      let id = 1;
      while (id <= 10000) {
        newList.push({id, name: "Item #" + 1});
        id++;
      }
    }

    this.itemList = newList;
  }
};
