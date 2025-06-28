import 'package:dio/dio.dart';

class PaymobManager {
  final String apiKey =
      "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRBek56TXpOaXdpYm1GdFpTSTZJbWx1YVhScFlXd2lmUS4ycmhsX3UxUFpGbFNMR2IxU3Z6Q205TjdGemMta0I4ZUIyQnE2UnNCRmRjUkVraDVYS3l1MHlYUUFzaFVGckhnNUxZT1l1QWNwRWtfb2hiSWpuMkxkUQ=="; // ✳️ استخدم نفس API Key من لوحة Paymob
  final int integrationId = 5043750; // ✳️ Integration ID الخاص بك
  final int iframeId = 913534; // ✅ من الكود

  Future<String> getPaymentKey(int amount, String currency) async {
    try {
      String authToken = await _getAuthToken();
      int orderId = await _getOrderId(authToken, amount.toString(), currency);
      String paymentKey = await _getPaymentKey(
          authToken, orderId.toString(), amount.toString(), currency);
      return paymentKey;
    } catch (e) {
      print("Error during Paymob Payment Key generation: $e");
      rethrow;
    }
  }

  Future<String> _getAuthToken() async {
    final response = await Dio().post(
      "https://accept.paymob.com/api/auth/tokens",
      data: {"api_key": apiKey},
    );
    return response.data["token"];
  }

  Future<int> _getOrderId(String token, String amount, String currency) async {
    final response = await Dio().post(
      "https://accept.paymob.com/api/ecommerce/orders",
      data: {
        "auth_token": token,
        "amount_cents": amount,
        "currency": currency,
        "delivery_needed": "false",
        "items": [],
      },
    );
    return response.data["id"];
  }

  Future<String> _getPaymentKey(
      String token, String orderId, String amount, String currency) async {
    final response = await Dio().post(
      "https://accept.paymob.com/api/acceptance/payment_keys",
      data: {
        "auth_token": token,
        "amount_cents": amount,
        "expiration": 3600,
        "order_id": orderId,
        "integration_id": integrationId,
        "currency": currency,
        "billing_data": {
          "first_name": "Ibrahim",
          "last_name": "Shafik",
          "email": "ibrahim@example.com",
          "phone_number": "+201000000000",
          "apartment": "NA",
          "floor": "NA",
          "street": "NA",
          "building": "NA",
          "shipping_method": "NA",
          "postal_code": "NA",
          "city": "Cairo",
          "country": "EG",
          "state": "NA"
        },
      },
    );
    return response.data["token"];
  }

  String getPaymentUrl(String paymentKey) {
    return "https://accept.paymob.com/api/acceptance/iframes/$iframeId?payment_token=$paymentKey";
  }
}
