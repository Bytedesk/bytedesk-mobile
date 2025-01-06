//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <bytedesk_common/bytedesk_common_plugin_c_api.h>
#include <bytedesk_kefu/bytedesk_kefu_plugin_c_api.h>
#include <bytedesk_push/bytedesk_push_plugin_c_api.h>
#include <connectivity_plus/connectivity_plus_windows_plugin.h>
#include <file_selector_windows/file_selector_windows.h>
#include <permission_handler_windows/permission_handler_windows_plugin.h>
#include <share_plus/share_plus_windows_plugin_c_api.h>
#include <url_launcher_windows/url_launcher_windows.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  BytedeskCommonPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("BytedeskCommonPluginCApi"));
  BytedeskKefuPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("BytedeskKefuPluginCApi"));
  BytedeskPushPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("BytedeskPushPluginCApi"));
  ConnectivityPlusWindowsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("ConnectivityPlusWindowsPlugin"));
  FileSelectorWindowsRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FileSelectorWindows"));
  PermissionHandlerWindowsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("PermissionHandlerWindowsPlugin"));
  SharePlusWindowsPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("SharePlusWindowsPluginCApi"));
  UrlLauncherWindowsRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("UrlLauncherWindows"));
}
