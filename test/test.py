
import paho.mqtt.client as mqtt
import mysql.connector
from datetime import datetime
import time
import json


# Kết nối với MySQL
def connect_to_mysql():
    return mysql.connector.connect(
        host="localhost",  # Thay bằng địa chỉ host của bạn
        user="root",  # Thay bằng user MySQL của bạn
        password="",  # Thay bằng password của bạn
        database="sql"  # Tên database MySQL của bạn
    )
# Callback khi kết nối MQTT thành công
def on_connect(client, userdata, flags, rc):
    if rc == 0:
        print("Connected to MQTT Broker!")
        client.subscribe("21004173/topic")  # Thay bằng topic bạn muốn lắng nghe
    else:
        print(f"Failed to connect, return code {rc}")


# Callback khi nhận tin nhắn
def on_message(client, userdata, msg):
    print(f"Received message: Topic={msg.topic}, Message={msg.payload.decode()}")
    
    # Lấy thông tin từ database
    conn = connect_to_mysql()
    cursor = conn.cursor(dictionary=True)  # Sử dụng dictionary=True để kết quả trả về dạng dictionary
    
    query = """
        SELECT traffic_signs.name, traffic_signs.description, sign_type.name_type 
        FROM traffic_signs 
        JOIN sign_type ON sign_type.id_sign_type = traffic_signs.id_sign_type 
        WHERE traffic_signs.name = %s
    """
    cursor.execute(query, (msg.payload.decode(),))
    result = cursor.fetchone()
    
    if result:
        # Tạo dictionary chứa thông tin
        response_data = {
            "name": result['name'],
            "description": result['description'],
            "type": result['name_type']
        }
        # Chuyển đổi sang JSON string
        json_response = json.dumps(response_data, ensure_ascii=False)
        publish_message(client, "21004173/output", json_response)
    else:
        error_response = {
            "error": "No data found"
        }
        publish_message(client, "21004173/output", json.dumps(error_response))
    
    cursor.close()
    conn.close()


# Hàm gửi tin nhắn
def publish_message(client, topic, message):
    client.publish(topic, message)
    print(f"Message published: Topic={topic}, Message={message}")


# Hàm chính luôn chạy
def main():
    broker = "broker.emqx.io"  # Thay bằng địa chỉ broker của bạn
    port = 1883
    client = mqtt.Client("MQTT_Python_Client")
    client.on_connect = on_connect
    client.on_message = on_message

    while True:
        try:
            # Kết nối đến MQTT broker
            print("Connecting to MQTT Broker...")
            client.connect(broker, port)

            # Chạy MQTT client trong vòng lặp
            client.loop_forever()
        except Exception as e:
            print(f"Error: {e}")
            print("Reconnecting in 5 seconds...")
            time.sleep(5)  # Chờ trước khi thử lại


if __name__ == "__main__":
    main()

# https://wokwi.com/projects/420562146358394881
# pip install paho-mqtt==1.6.1
# pip install mysql-connector-python