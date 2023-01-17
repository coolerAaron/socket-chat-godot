extends Control


signal addToMessageLog(message)

var ws = WebSocketClient.new()
export var URL = "ws://localhost:3000/"
var last_status = -1
func _ready():
	ws.connect('connection_closed', self, '_closed')
	ws.connect('connection_error', self, '_error')
	ws.connect('connection_established', self, '_connected')
	ws.connect('data_received', self, '_on_data')
	connectServer()
		
func connectServer():
	var err = ws.connect_to_url(URL)
	print('err: ' + str(err))
	if err != OK:
		print('connection refused')
func _on_data():
	var payload = JSON.parse(ws.get_peer(1).get_packet().get_string_from_utf8()).result
	print(payload)
	emit_signal("addToMessageLog", payload.user + ": " + payload.message)
func _closed(clean_close):
	print("connection closed: " + str(clean_close))
	
func _error():
	print("connection closed due to error")
	
func _connected(protocol):
	ws.get_peer(1).set_write_mode(WebSocketPeer.WRITE_MODE_TEXT)
	print("connected to host with protocol: " + str(protocol))
	


func _process(delta):
	var status = ws.get_connection_status()
	
	if status == WebSocketServer.CONNECTION_DISCONNECTED:
		#connectServer()
		#yield(get_tree().create_timer(5), 'timeout')
		pass
	
	if status != last_status:
		last_status = status
		#print('Connection Status: ' + str(status))
		#if ws.get_connected_host():
		#	print('Connected Host: ' + str(ws.get_connected_host()))
	ws.poll()

func _on_MessageInput_message_sent(message):
	ws.get_peer(1).put_packet(message.to_utf8())
	
