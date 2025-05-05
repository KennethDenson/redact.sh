# redact.sh

**redact.sh** is a dead-simple Bash script that redacts sensitive values from config files like `.env`, `.json`, and `.yaml` for safe sharing on support forums, Discord, or ChatGPT. It highlights redacted lines in red so you can quickly verify what's been scrubbed.

---

## 🚀 Features

- ✅ Redacts full values for keys like `API_KEY`, `PASSWORD`, `SECRET_KEY`, etc.
- ✅ Reads custom patterns from `.redact-patterns`
- ✅ Supports `.env`, `.json`, and `.yaml` formats
- ✅ Highlights redacted lines in red in your terminal
- ✅ POSIX-compatible (works on macOS, Linux, WSL)

---

## 🧠 Example

Input:
```env
API_KEY=abcd1234
"api_key": "abcd1234",
api_key: abcd1234
SAFE_VAR=ThisIsFine
```

Output:
```env
API_KEY=REDACTED               ← in red
"api_key": "REDACTED",         ← in red
api_key: REDACTED              ← in red
SAFE_VAR=ThisIsFine
```

---

## 🛠️ Usage

```bash
./redact.sh path/to/your/file.env
```

Want to test it?

```bash
./redact.sh sample.env
```

---

## 🧩 Customize Keys

Edit `.redact-patterns` to specify which keys should be redacted (case-insensitive):

```text
API_KEY
PASSWORD
SECRET_KEY
JWT
DB_USER
```

---

## 📦 Installation (Optional)

If you want to make it globally available:

```bash
chmod +x redact.sh
sudo ln -s "$(pwd)/redact.sh" /usr/local/bin/redact
```

Now you can run:

```bash
redact myfile.env
```

---

## 🪪 License

MIT — do whatever you want, but don't blame me if you nuke your prod secrets 😇
