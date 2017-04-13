import BasePolicy from '../base_policy';

export default class StagePolicy extends BasePolicy {
  constructor(props) {
    super(props);
    this.registerRefresh(this);
    this.controller = 'stages';
  }
}
