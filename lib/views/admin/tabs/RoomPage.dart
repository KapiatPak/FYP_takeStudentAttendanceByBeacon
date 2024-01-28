import 'package:flutter/material.dart';
import '../../../services/db_service.dart';

class RoomPage extends StatefulWidget {
  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  late List<Map<String, dynamic>> _rooms;
  final _dbService = DatabaseService.instance;

  @override
  void initState() {
    super.initState();
    _loadRooms();
  }

  void _loadRooms() async {
    _rooms = await _dbService.getRooms();
    setState(() {});
  }

  void _addOrUpdateRoom({Map<String, dynamic>? room}) async {
    final _roomNameController = TextEditingController(
      text: room != null ? room['room_name'] : '',
    );

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(room == null ? 'Add Room' : 'Update Room'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: _roomNameController,
                  decoration: InputDecoration(labelText: 'Room Name'),
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
              child: Text(room == null ? 'Add' : 'Update'),
              onPressed: () async {
                final String name = _roomNameController.text;
                if (room == null) {
                  // Add new room
                  await _dbService.createRoom({'room_name': name});
                } else {
                  // Update existing room
                  await _dbService.updateRoom({
                    'room_id': room['room_id'],
                    'room_name': name,
                  });
                }
                _loadRooms(); // Reload the list of rooms
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteRoom(int id) async {
    await _dbService.deleteRoom(id);
    _loadRooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room Management'),
        automaticallyImplyLeading: false, // 移除自动添加的返回箭头
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _dbService.getRooms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No rooms found'));
          } else {
            _rooms = snapshot.data!;
            return ListView.builder(
              itemCount: _rooms.length,
              itemBuilder: (context, index) {
                var room = _rooms[index];
                return ListTile(
                  title: Text(room['room_name']),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteRoom(room['room_id']),
                  ),
                  onTap: () => _addOrUpdateRoom(room: room),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _addOrUpdateRoom(),
      ),
    );
  }
}