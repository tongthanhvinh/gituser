from flask import Flask, jsonify, request
from faker import Faker
import random

app = Flask(__name__)
fake = Faker()

# Generate mock users
NUM_USERS = 99
users = []

for i in range(1, NUM_USERS + 1):
    username = fake.user_name()
    users.append({
        "id": i,
        "login": username,
        "avatar_url": f"https://avatars.githubusercontent.com/u/{i}?v=4",
        "html_url": f"https://github.com/{username}",
        "location": fake.city(),
        "followers": random.randint(0, 5000),
        "following": random.randint(0, 500)
    })

users.append({
    "id": 10725542,
    "login": "tongthanhvinh",
    "avatar_url": f"https://avatars.githubusercontent.com/u/10725542?v=4",
    "html_url": f"https://github.com/tongthanhvinh",
    "location": "Viet Nam",
    "followers": 0,
    "following": 0
})

# Convert list to dict for quick lookup
user_dict = {user["login"]: user for user in users}

@app.route('/users', methods=['GET'])
def get_users():
    per_page = int(request.args.get('per_page', 20))
    since = int(request.args.get('since', 0))

    filtered_users = [user for user in users if user["id"] > since]
    paginated_users = filtered_users[:per_page]
    response = [
        {
            "id": user["id"],
            "login": user["login"],
            "avatar_url": user["avatar_url"],
            "html_url": user["html_url"]
        }
        for user in paginated_users
    ]
    return jsonify(response)

@app.route('/users/<string:login>', methods=['GET'])
def get_user_details(login):
    user = user_dict.get(login)
    if not user:
        return jsonify({"error": "User not found"}), 404
    return jsonify(user)

if __name__ == '__main__':
    app.run(debug=True, port=5000)
