//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <native_pdf_renderer/native_pdf_renderer_plugin.h>
#include <pdfx/native_pdf_renderer_plugin.h>
#include <printing/printing_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  NativePdfRendererPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("NativePdfRendererPlugin"));
  NativePdfRendererPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("NativePdfRendererPlugin"));
  PrintingPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("PrintingPlugin"));
}
