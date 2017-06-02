import Component, { tracked } from '@glimmer/component';

export default class ModelDisplay extends Component {
  @tracked model = null;

  increment() {
    console.log("Increment");
  }

  decrement() {
    console.log("Decrement");
  }
}
