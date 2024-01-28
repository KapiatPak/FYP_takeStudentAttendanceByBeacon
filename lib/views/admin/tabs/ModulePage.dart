import 'package:flutter/material.dart';
import '../../../services/db_service.dart';

class ModulePage extends StatefulWidget {
  @override
  _ModulePageState createState() => _ModulePageState();
}

class _ModulePageState extends State<ModulePage> {
  late List<Map<String, dynamic>> _modules;
  final _dbService = DatabaseService.instance;

  @override
  void initState() {
    super.initState();
    _loadModules();
  }

  void _loadModules() async {
    _modules = await _dbService.getModules();
    setState(() {});
  }

  void _addOrUpdateModule({Map<String, dynamic>? module}) async {
    final _moduleNameController = TextEditingController(
      text: module != null ? module['module_name'] : '',
    );

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(module == null ? 'Add Module' : 'Update Module'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: _moduleNameController,
                  decoration: InputDecoration(labelText: 'Module Name'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(module == null ? 'Add' : 'Update'),
              onPressed: () async {
                final String name = _moduleNameController.text;
                if (module == null) {
                  // Add new module
                  await _dbService.createModule({'module_name': name});
                } else {
                  // Update existing module
                  await _dbService.updateModule({
                    'module_id': module['module_id'],
                    'module_name': name,
                  });
                }
                _loadModules(); // Reload the list of modules
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteModule(int id) async {
    await _dbService.deleteModule(id);
    _loadModules();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Module Management'),
        automaticallyImplyLeading: false, // 移除自动添加的返回箭头
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _dbService.getModules(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No modules found'));
          } else {
            _modules = snapshot.data!;
            return ListView.builder(
              itemCount: _modules.length,
              itemBuilder: (context, index) {
                var module = _modules[index];
                return ListTile(
                  title: Text(module['module_name']),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteModule(module['module_id']),
                  ),
                  onTap: () => _addOrUpdateModule(module: module),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _addOrUpdateModule(),
      ),
    );
  }
}