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
        newList.push({id, name: "Item #" + id});
        id++;
      }
    }
    else {
      newList = this.itemList.map((item) => {
        if (Math.random() > 0.9) {
          return Object.assign({}, item, { name: item.name + "0" });
        }
        else {
          return item;
        }
      });
    }

    this.itemList = newList;
  }
};
