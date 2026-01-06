# Telegram Auto-Sender Bot

This is an automated Telegram message sender that sends sequential email addresses to a Telegram bot.

## Features
- ✅ Automated email sending to Telegram bots
- ✅ Resume capability with state saving
- ✅ Rate limiting and anti-flood protection
- ✅ Dynamic delays to avoid spam detection
- ✅ Exponential backoff on errors

## Quick Start

### Option 1: Run with Auto-Update (Recommended)

1. Download [run.bat](run.bat)
2. Double-click `run.bat`
3. The script will:
   - Download the latest version from GitHub
   - Install dependencies
   - Run the bot automatically

### Option 2: Manual Installation

1. Clone this repository:
```bash
git clone https://github.com/YOUR_USERNAME/conversion-from-py.git
cd conversion-from-py
```

2. Install dependencies:
```bash
pip install -r requirements.txt
```

3. Edit the configuration in `telegram-1.py`:
   - Set your `API_ID` and `API_HASH` from [my.telegram.org](https://my.telegram.org)
   - Change `TARGET` to your desired recipient
   - Adjust email settings as needed

4. Run the script:
```bash
python telegram-1.py
```

## Configuration

Edit these variables in `telegram-1.py`:

```python
API_ID = 20804419                    # Your Telegram API ID
API_HASH = "your_api_hash_here"      # Your Telegram API Hash
TARGET = "@fakemailbot"              # Target bot username
EMAIL_PREFIX = "jasus"               # Email prefix
EMAIL_DOMAIN = "@hi2.in"             # Email domain
START_NUM = 1                        # Starting number
END_NUM = 500                        # Ending number
MAX_PER_MIN = 40                     # Max messages per minute
```

## Requirements

- Python 3.7+
- telethon library

## How It Works

1. Generates sequential emails (e.g., jasus01@hi2.in, jasus02@hi2.in)
2. Sends them to the specified Telegram bot/user
3. Saves progress to `state.json` for resuming
4. Implements multiple anti-spam measures:
   - Rate limiting (40 msgs/min)
   - Dynamic delays between messages
   - Burst breaker (pause after 5 consecutive sends)
   - 10-message gaps
   - FloodWait error handling with exponential backoff

## Safety Features

- State file for resuming interrupted sessions
- Automatic backoff on flood errors
- Rate limiting to avoid Telegram restrictions
- Random jitter in delays to appear more human-like

## Disclaimer

Use this tool responsibly and in accordance with Telegram's Terms of Service. The author is not responsible for any misuse of this tool.
