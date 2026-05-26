# How to take the README screenshot

1. **Open both Claudes**, each with a **fresh empty conversation** (`⌘N`).
2. Type a generic prompt in each that shows "this is a different account":
   - Left (account #1): `Hello from my personal account`
   - Right (account #2): `Hello from my work account`
3. Send, wait for the response to finish rendering.
4. Arrange windows side by side (use Mission Control or just drag).
5. Capture: `⌘ + Shift + 4`, then press `Space`, click each window — or use `⌘ + Shift + 4` and drag a region covering both.
6. Save the file as `docs/screenshot.png` in this repo.
7. Commit and push:
   ```bash
   git add docs/screenshot.png
   git commit -m "Add README screenshot"
   git push
   ```

The README already references `docs/screenshot.png`, so it'll show up on the repo page automatically once you push.
