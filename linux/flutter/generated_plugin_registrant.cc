//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <bytedesk_common/bytedesk_kefu_plugin.h>
#include <bytedesk_kefu/bytedesk_kefu_plugin.h>
#include <bytedesk_push/bytedesk_push_plugin.h>
#include <file_selector_linux/file_selector_plugin.h>
#include <url_launcher_linux/url_launcher_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) bytedesk_common_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "BytedeskKefuPlugin");
  bytedesk_kefu_plugin_register_with_registrar(bytedesk_common_registrar);
  g_autoptr(FlPluginRegistrar) bytedesk_kefu_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "BytedeskKefuPlugin");
  bytedesk_kefu_plugin_register_with_registrar(bytedesk_kefu_registrar);
  g_autoptr(FlPluginRegistrar) bytedesk_push_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "BytedeskPushPlugin");
  bytedesk_push_plugin_register_with_registrar(bytedesk_push_registrar);
  g_autoptr(FlPluginRegistrar) file_selector_linux_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "FileSelectorPlugin");
  file_selector_plugin_register_with_registrar(file_selector_linux_registrar);
  g_autoptr(FlPluginRegistrar) url_launcher_linux_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "UrlLauncherPlugin");
  url_launcher_plugin_register_with_registrar(url_launcher_linux_registrar);
}
