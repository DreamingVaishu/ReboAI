# ReboAI

A modern AI-powered chat application built with Flutter frontend and FastAPI backend. ReboAI provides a seamless conversational interface with real-time messaging and animated processing indicators.

## 🚀 Features

- **Real-time Chat**: Interactive messaging interface with instant responses
- **Animated Processing**: Beautiful 4-dot animation during AI processing
- **Modern UI**: Clean, responsive design with gradient backgrounds
- **Cross-platform**: Works on Windows, Web (Chrome/Edge), and mobile devices
- **FastAPI Backend**: High-performance Python backend with OpenAI integration
- **Error Handling**: Graceful error handling with user-friendly messages

## 📱 Screenshots

*Add screenshots here when available*

## 🛠️ Tech Stack

### Frontend (Flutter)
- **Flutter 3.11.4+** - Cross-platform UI framework
- **HTTP 1.1.0** - API communication
- **Font Awesome 10.7.0** - Icon library
- **Flutter SVG 2.0.9** - SVG rendering support

### Backend (Python/FastAPI)
- **FastAPI 0.104.1** - Modern, fast web framework
- **Uvicorn 0.24.0** - ASGI server
- **OpenAI 1.3.8** - AI model integration
- **Pydantic 2.5.0** - Data validation
- **Python-dotenv 1.0.0** - Environment variable management

## 📋 Prerequisites

### For Frontend
- Flutter SDK 3.11.4 or higher
- Dart SDK compatible with Flutter version
- Visual Studio Code (recommended) or Android Studio

### For Backend
- Python 3.8 or higher
- pip package manager

## 🚀 Installation

### 1. Clone the Repository
```bash
git clone https://github.com/DreamingVaishu/ReboAI.git
cd ReboAI
```

### 2. Backend Setup
```bash
# Navigate to backend directory
cd rebobackend

# Create virtual environment (recommended)
python -m venv venv

# Activate virtual environment
# On Windows:
venv\Scripts\activate
# On macOS/Linux:
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Create .env file for OpenAI API key
echo "OPENAI_API_KEY=your_api_key_here" > .env
```

### 3. Frontend Setup
```bash
# Navigate to frontend directory
cd rebo_ai

# Install Flutter dependencies
flutter pub get

# Check for any issues
flutter doctor
```

## 🏃‍♂️ Running the Application

### Start the Backend Server
```bash
cd rebobackend
python main.py
```
The backend will start on `http://localhost:8000`

### Start the Flutter Application
```bash
cd rebo_ai
flutter run
```

Choose your target platform when prompted:
- Windows (desktop)
- Chrome (web)
- Edge (web)

## 📁 Project Structure

```
ReboAI/
├── rebo_ai/                 # Flutter frontend
│   ├── lib/
│   │   ├── pages/          # Application pages
│   │   │   └── rebochat.dart # Main chat interface
│   │   ├── components/     # Reusable components
│   │   ├── assets/         # Images and assets
│   │   └── main.dart       # App entry point
│   ├── android/            # Android-specific files
│   ├── ios/                # iOS-specific files
│   ├── windows/            # Windows-specific files
│   └── pubspec.yaml        # Flutter dependencies
├── rebobackend/            # FastAPI backend
│   ├── main.py            # Main application file
│   ├── requirements.txt   # Python dependencies
│   └── .env               # Environment variables
└── README.md              # This file
```

## 🔧 Configuration

### Backend Configuration
Create a `.env` file in the `rebobackend` directory with your OpenAI API key:
```
OPENAI_API_KEY=your_openai_api_key_here
```

### Frontend Configuration
The frontend is configured to connect to the backend at `http://localhost:8000/chat`. To change this, modify the URL in `lib/pages/rebochat.dart`:
```dart
final response = await http.post(
  Uri.parse('http://localhost:8000/chat'), // Change this URL if needed
  headers: {'Content-Type': 'application/json'},
  body: jsonEncode({'message': message}),
);
```

## 🎨 UI Features

- **Animated Processing Indicator**: 4-dot pulsing animation during AI responses
- **Message Bubbles**: Distinct styling for user and AI messages
- **Smooth Scrolling**: Auto-scroll to latest messages
- **Responsive Design**: Adapts to different screen sizes
- **Modern Styling**: Gradient backgrounds and rounded corners

## 🐛 Troubleshooting

### Common Issues

1. **Backend Connection Error**
   - Ensure the backend server is running on `http://localhost:8000`
   - Check if port 8000 is available
   - Verify your firewall settings

2. **Flutter Build Issues**
   - Run `flutter doctor` to check for missing dependencies
   - Clean and rebuild: `flutter clean && flutter pub get && flutter run`

3. **OpenAI API Issues**
   - Verify your API key is correctly set in the `.env` file
   - Check your OpenAI API quota and billing

4. **Animation Not Working**
   - Ensure the app is hot-restarted after changes
   - Check for null safety exceptions in the console

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Flutter](https://flutter.dev/) for the amazing cross-platform framework
- [FastAPI](https://fastapi.tiangolo.com/) for the modern Python web framework
- [OpenAI](https://openai.com/) for providing powerful AI capabilities

## 📞 Support

If you encounter any issues or have questions, please:
1. Check the [Troubleshooting](#-troubleshooting) section
2. Search existing [Issues](https://github.com/DreamingVaishu/ReboAI/issues)
3. Create a new issue with detailed information

---

**ReboAI** - Your AI conversation companion 🤖✨

