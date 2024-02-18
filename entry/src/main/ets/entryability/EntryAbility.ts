import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';
import { Auth } from '../common/utils/Auth';
import { Logger } from '../common/utils/Logger';

export default class EntryAbility extends UIAbility {
  onCreate(want, launchParam) {
    Auth.initLocalUser()
    Logger.info('%{public}s', 'Ability onCreate');
  }

  onDestroy() {
    Logger.info('%{public}s', 'Ability onDestroy');
  }
  storage = new LocalStorage({
    user: {
      age: 132
    }
  })
  onWindowStageCreate(windowStage: window.WindowStage) {
    // Main window is created, set main page for this ability
    Logger.info('%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', this.storage, (err, data) => {
      if (err.code) {
        Logger.error('Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      Logger.info('Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
  }

  onWindowStageDestroy() {
    // Main window is destroyed, release UI related resources
    Logger.info('%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground() {
    // Ability has brought to foreground
    Logger.info('%{public}s', 'Ability onForeground');
  }

  onBackground() {
    // Ability has back to background
    Logger.info('%{public}s', 'Ability onBackground');
  }
}
