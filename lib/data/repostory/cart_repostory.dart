import 'package:vazifa33/data/model/cart_model.dart';
import 'package:vazifa33/services/cart_service.dart';

class CartsRepository {
  final FirbaseCartService _firebaseCartService;

  CartsRepository({required FirbaseCartService firebaseCartService})
      : _firebaseCartService = firebaseCartService;

  Stream<List<CartModel>> getCart() {
    return _firebaseCartService.getCart();
  }

  Future<void> addCart(CartModel cart) async {
    await _firebaseCartService.addCart(cart);
  }

}