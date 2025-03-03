# GitUser

## Overview

GitUser is an iOS application built using SwiftUI, SwiftData, Combine, and Async/Await. The app fetches and displays GitHub users with features such as pagination, persistent data storage, and smooth navigation.

## Features

- Fetch and display GitHub users
- Pagination for seamless browsing
- Persistent storage using SwiftData
- Smooth navigation with SwiftUI
- Efficient data handling with Combine and Async/Await
- Unit testing for reliability
- Supports a Fake Server for development
- Dark Mode UI support
- Multi-platform support: iPhone, iPad, Mac (Designed for iPad), Apple Vision (Designed for iPad)

## Installation

### Prerequisites

- Xcode (latest version recommended)
- macOS (latest version recommended)
- GitHub API access token (if needed for authentication)

### Steps

1. Clone the repository:
   ```sh
   git clone https://github.com/tongthanhvinh/gituser.git
   ```
2. Open the project in Xcode:
   ```sh
   cd gituser
   open GitUser.xcodeproj
   ```
3. Build and run the project using Xcode.

## Running the Fake Server
To use a mock API for development, follow these steps:

### 1️⃣ Selecting the Development Scheme
1. Open **Xcode** and load `GitUser.xcodeproj`.
2. Click on the **Scheme Selector** and choose **`Dev`**.

### 2️⃣ Running the Fake Server
#### Using Python:
1. Navigate to the `FakeServer` directory:
   ```sh
   cd FakeServer
   ```
2. Install dependencies:
   ```sh
   pip install -r requirements.txt
   ```
3. Start the Fake Server:
   ```sh
   python main.py
   ```
4. The API will be available at `http://127.0.0.1:5000/`.

### 3️⃣ Running the App with Fake Server
1. Ensure the Fake Server is running.
2. In Xcode, select **`Dev`** scheme.
3. Click **Run** to start the app.

## Usage

- Launch the app to browse GitHub users.
- Scroll to load more users with pagination.
- View detailed user profiles.

## Contributing

1. Fork the repository.
2. Create a new branch (`feature/new-feature`).
3. Commit your changes.
4. Push the branch and create a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

