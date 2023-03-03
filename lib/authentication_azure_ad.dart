library authentication_azure_ad;

import 'dart:math';

import 'package:openid_client/openid_client_browser.dart' as open_id;

class AzureADAuthentication {
  static Future<String> getToken(
      String tenantId, String clientId, List<String> scopes) async {
    if (Uri.base.toString().contains("access_token=")) {
      var idxStart =
          Uri.base.toString().indexOf("access_token=") + "access_token=".length;
      var idxEnd = min(Uri.base.toString().length - 1,
          Uri.base.toString().indexOf("&token_type="));
      var accessToken = Uri.base.toString().substring(idxStart, idxEnd);
      return accessToken;
    } else {
      var issuer = await open_id.Issuer.discover(
          Uri.parse("https://login.microsoftonline.com/$tenantId/v2.0"));
      var client = open_id.Client(issuer, clientId);

      var authenticator = open_id.Authenticator(client, scopes: scopes);
      await authenticator.credential;
      authenticator.authorize();
    }

    return 'waiting ...';
  }
}
