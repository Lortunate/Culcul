import 'package:culcul/features/auth/domain/entities/country_code.dart';
import 'package:culcul/i18n/i18n.dart';
import 'package:culcul/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:culcul/ui/widgets/app_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CountryCodeSelectionPage extends HookConsumerWidget {
  const CountryCodeSelectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final countryCodes = useState<List<CountryCode>>(defaultCountryCodes);
    final isLoading = useState(true);
    final searchController = useTextEditingController();
    final searchQuery = useState('');

    useEffect(() {
      Future<void> fetch() async {
        final list = await ref.read(authProvider.notifier).getCountryList();
        if (list.isNotEmpty) {
          countryCodes.value = list;
        }
        if (context.mounted) {
          isLoading.value = false;
        }
      }

      fetch();
      return null;
    }, []);

    useEffect(() {
      void listener() {
        searchQuery.value = searchController.text.toLowerCase();
      }

      searchController.addListener(listener);
      return () => searchController.removeListener(listener);
    }, [searchController]);

    // Filter and group
    final filteredList = useMemoized(() {
      final query = searchQuery.value;
      if (query.isEmpty) {
        return countryCodes.value;
      }
      return countryCodes.value.where((c) {
        return c.name.toLowerCase().contains(query) || c.code.contains(query);
      }).toList();
    }, [countryCodes.value, searchQuery.value]);

    final t = i18n(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(t.auth.select_country),
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: AppSearchBar(
              controller: searchController,
              hintText: t.auth.search_country_hint,
              suffixIcon: searchQuery.value.isNotEmpty
                  ? GestureDetector(
                      onTap: () => searchController.clear(),
                      child: Icon(
                        Icons.cancel,
                        size: 16,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    )
                  : null,
            ),
          ),
          // List
          Expanded(
            child: isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : filteredList.isEmpty
                ? Center(
                    child: Text(
                      t.auth.no_search_result,
                      style: TextStyle(color: colorScheme.onSurfaceVariant),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final country = filteredList[index];
                      return ListTile(
                        onTap: () => Navigator.of(context).pop(country),
                        title: Text(country.name, style: theme.textTheme.bodyLarge),
                        trailing: Text(
                          country.code,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace',
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
}
