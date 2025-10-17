import 'package:flutter/material.dart';
import 'package:profile_explorer/presentation/providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/profile_card.dart';
import '../detail/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     'Profile Explorer',
      //     style: TextStyle(fontWeight: FontWeight.bold),
      //   ),
      //   centerTitle: true,
      // ),
      body: Builder(
        builder: (_) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(child: Text(provider.error!));
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: provider.availableCountries.contains(provider.selectedCountry)
                        ? provider.selectedCountry
                        : null,
                    hint: const Text('Filter by country'),
                    items: [
                      const DropdownMenuItem<String>(
                        value: null,
                        child: Text('All Countries'),
                      ),
                      ...provider.availableCountries.map((country) {
                        return DropdownMenuItem<String>(
                          value: country,
                          child: Text(country),
                        );
                      }).toList(),
                    ],
                    onChanged: (value) => provider.setCountry(value),
                  ),
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await provider.fetchUsers();
                  },
                  child: GridView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: provider.filteredUsers.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.8,
                        ),
                    itemBuilder: (context, index) {
                      final user = provider.filteredUsers[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailScreen(user: user),
                            ),
                          );
                        },
                        child: Hero(
                          tag: user.imageUrl,
                          child: ProfileCard(user: user),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
