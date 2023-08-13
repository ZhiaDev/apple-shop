import 'package:uni_links/uni_links.dart';
import 'package:zarinpal/zarinpal.dart';

import '/utility/string_extension.dart';
import '/utility/url_handler.dart';

abstract class PaymentHandler {
  Future<void> initPaymentRquest();
  Future<void> sendPaymentRquest();
  Future<void> verifyPaymentRquest();
}

class ZarinPalPaymentHandler extends PaymentHandler {
  final PaymentRequest _paymentRequest = PaymentRequest();
  String? _authority;
  String? _status;
  UrlHandler urlHandler = UrlLauncher();

  @override
  Future<void> initPaymentRquest() async {
    _paymentRequest.setIsSandBox(true);
    _paymentRequest.setAmount(1000);
    _paymentRequest.setDescription('tozihat bija');
    _paymentRequest.setMerchantID('00eb9bdf-b08c-466c-b2ef-6d5b1702e635');
    _paymentRequest.setCallbackURL('arioapp://appleshop');

    linkStream.listen((deepLink) {
      if (deepLink!.toLowerCase().contains('authority')) {
        _authority = deepLink.extractValueFromQuery('Authority');
        _status = deepLink.extractValueFromQuery('Status');
        verifyPaymentRquest();
      }
    });
  }

  @override
  Future<void> sendPaymentRquest() async {
    ZarinPal().startPayment(_paymentRequest, (status, paymentGatewayUri) {
      if (status == 100) {
        urlHandler.openUrl(paymentGatewayUri!);
      }
    });
  }

  @override
  Future<void> verifyPaymentRquest() async {
    ZarinPal().verificationPayment(
      _status ?? '',
      _authority ?? '',
      _paymentRequest,
      (isPaymentSuccess, refID, paymentRequest) {
        if (isPaymentSuccess) {
          print(refID);
        } else {
          print('error');
        }
      },
    );
  }
}
