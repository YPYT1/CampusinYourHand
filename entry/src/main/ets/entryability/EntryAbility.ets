import { AbilityConstant, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';

const DOMAIN = 0x0000;

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.getMainWindow((err, data) => {
      if (err.code) {
        hilog.error(DOMAIN, 'testTag', 'Failed to obtain the main window. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      // 沉浸式状态栏
      data.setWindowSystemBarEnable([]);
      let properties: window.SystemBarProperties = {
        statusBarColor: '#00000000',
        navigationBarColor: '#00000000',
        // 以下两个属性从APIVersion11开始支持
        // isStatusBarLightIcon: false,
        // isNavigationBarLightIcon: false
      };
      data.setWindowSystemBarProperties(properties);
      data.setWindowLayoutFullScreen(true);

      // 获取状态栏高度并存入AppStorage
      try {
        let avoidArea = data.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM);
        // 使用AppStorage.setOrCreate替代AppStorage.SetOrCreate
        globalThis.AppStorage = globalThis.AppStorage || {};
        globalThis.AppStorage['statusBarHeight'] = avoidArea.topRect.height;
      } catch (err) {
        hilog.error(DOMAIN, 'testTag', 'Failed to get window avoid area. Cause: %{public}s', JSON.stringify(err) ?? '');
      }

      data.loadContent('pages/Index', (err, data) => {
        if (err.code) {
          hilog.error(DOMAIN, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
          return;
        }
        hilog.info(DOMAIN, 'testTag', 'Succeeded in loading the content.');
      });
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onBackground');
  }
}