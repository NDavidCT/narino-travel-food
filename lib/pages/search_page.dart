import 'package:flutter/material.dart';

import '../models/destination.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  List<Destination> _results = [];

  @override
  void initState() {
    super.initState();
    // Mostrar todos inicialmente
    _results = List<Destination>.from(destinations);
  }

  void _doSearch(String query) {
    final q = query.trim().toLowerCase();
    setState(() {
      if (q.isEmpty) {
        _results = List<Destination>.from(destinations);
      } else {
        _results = destinations.where((d) {
          final city = d.city?.toLowerCase() ?? '';
          final desc = d.description?.toLowerCase() ?? '';
          final activitiesMatch = d.activities
                  ?.any((a) => (a.name ?? '').toLowerCase().contains(q)) ??
              false;
          return city.contains(q) || desc.contains(q) || activitiesMatch;
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Buscar destinos o actividades...',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onSubmitted: _doSearch,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _doSearch(_controller.text),
                  child: const Text('Buscar'),
                ),
              ],
            ),
          ),
          Expanded(
            child: _results.isEmpty
                ? const Center(child: Text('No se encontraron resultados.'))
                : ListView.builder(
                    itemCount: _results.length,
                    itemBuilder: (context, index) {
                      final d = _results[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: ListTile(
                          leading: d.imageUrl != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.asset(
                                    d.imageUrl!,
                                    width: 64,
                                    height: 64,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Icon(Icons.location_on),
                          title: Text('${d.city ?? ''} - ${d.country ?? ''}'),
                          subtitle: Text(d.description ?? ''),
                          onTap: () {
                            // Por ahora solo mostrar diálogo con info
                            showDialog<void>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(d.city ?? 'Destino'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (d.historyAndInfo != null)
                                        Text(d.historyAndInfo!),
                                      const SizedBox(height: 12),
                                      const Text('Actividades:'),
                                      const SizedBox(height: 6),
                                      if (d.activities != null)
                                        ...d.activities!.map((a) =>
                                            Text('- ${a.name} (${a.type})'))
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Cerrar'))
                                ],
                              ),
                            );
                          },
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
