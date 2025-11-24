import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

void main() {
  runApp(const AiComedyClubApp());
}

class AiComedyClubApp extends StatelessWidget {
  const AiComedyClubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Comedy Club',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ComedyHomePage(),
    );
  }
}

class AdkService {
  // Android Emulator uses 10.0.2.2 to access localhost
  static const String baseUrl = 'http://10.0.2.2:8080';

  // Assuming the agent name matches the folder name or default configuration
  // You might need to adjust this based on how ADK registers the agent
  static const String agentName = 'default';

  final String userId = 'user_${const Uuid().v4().substring(0, 8)}';
  final String sessionId = 'session_${const Uuid().v4().substring(0, 8)}';

  Future<void> createSession() async {
    final url = Uri.parse(
      '$baseUrl/apps/$agentName/users/$userId/sessions/$sessionId',
    );
    print('Creating session at: $url');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('Session created successfully');
      } else {
        print('Failed to create session: ${response.body}');
        // Don't throw here, sometimes session creation is implicit or idempotent
      }
    } catch (e) {
      print('Error creating session: $e');
    }
  }

  Future<String> sendMessage(String topic) async {
    final url = Uri.parse('$baseUrl/run_sse');

    final payload = {
      "app_name": agentName,
      "user_id": userId,
      "session_id": sessionId,
      "new_message": {
        "role": "user",
        "parts": [
          {"text": "Tell me a joke about $topic"},
        ],
      },
      "streaming": false,
    };

    print('Sending message: $payload');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        // Parse the response. The structure depends on ADK output.
        // Usually it returns a JSON stream or a JSON object.
        // Since we set streaming: false, we expect a JSON object.
        print('Response body: ${response.body}');

        // Simple parsing logic - adjust based on actual response structure
        // If response is SSE format but not streaming, it might still need parsing
        return response.body;
      } else {
        throw Exception(
          'Failed to get joke: ${response.statusCode} ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

class ComedyHomePage extends StatefulWidget {
  const ComedyHomePage({super.key});

  @override
  State<ComedyHomePage> createState() => _ComedyHomePageState();
}

class _ComedyHomePageState extends State<ComedyHomePage> {
  final TextEditingController _controller = TextEditingController();
  final AdkService _adkService = AdkService();
  String _joke = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeSession();
  }

  Future<void> _initializeSession() async {
    await _adkService.createSession();
  }

  Future<void> _getJoke() async {
    if (_controller.text.isEmpty) return;

    setState(() {
      _isLoading = true;
      _joke = '';
    });

    try {
      final result = await _adkService.sendMessage(_controller.text);
      setState(() {
        _joke = result;
      });
    } catch (e) {
      setState(() {
        _joke = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Comedy Club 🎭'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter a topic (e.g., Cats, Traffic)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _getJoke,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Tell me a joke!'),
            ),
            const SizedBox(height: 30),
            if (_joke.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.purple.shade100),
                ),
                child: Text(
                  _joke,
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
