import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa33/logic/bloc/cart_bloc.dart';
import 'package:vazifa33/services/auth_servise.dart';
import 'package:vazifa33/ui/widget/cart_add.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final authFirebaseServices = FirebaseAuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0x8B3881E0),
        centerTitle: true,
        title: const Text(
          "Carts Screen",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              authFirebaseServices.logoutUser();
              setState(() {});
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        bloc: context.read<CartBloc>()..add(GetCartEvent()),
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ErrorState) {
            return const Center(
              child: Text("Kartalar Yuklanishida Xatolik!!!"),
            );
          }
          if (state is LoadedState) {
            final cart = state.carts;

            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://i.pinimg.com/originals/a0/72/92/a0729232de71cbe5a5b4e5695079af1d.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  cart.isEmpty
                      ? const Center(
                          child: Text(
                            "Kartalar Mavjud Emas...",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 250,
                          child: PageView.builder(
                            itemCount: cart.length,
                            itemBuilder: (context, index) {
                              final carts = cart[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                          "https://kartinki.pics/uploads/posts/2021-07/1626159513_16-kartinkin-com-p-bank-fon-krasivo-16.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(20),
                                  height: 250,
                                  width: 330,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Infin Bank",
                                        style: TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        carts.cartName,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            height: 65,
                                            child: Image.network(
                                              "https://million-wallpapers.ru/wallpapers/1/58/11515543991014903663/karta-zeml-chornij-fon.jpg",
                                              height: 40,
                                              width: 55,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                carts.balance,
                                                style: const TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              const Text(
                                                "So'm",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Transform.rotate(
                                            angle: 33,
                                            child: const Icon(
                                              Icons.wifi,
                                              size: 33,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        carts.cartNumber,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        carts.axpiryDate,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ZoomTapAnimation(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => const CardInfoDialog(),
          );
        },
        child: Container(
          width: 300,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color.fromARGB(244, 33, 54, 215),
          ),
          child: const Center(
            child: Text(
              "Add Cart",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
