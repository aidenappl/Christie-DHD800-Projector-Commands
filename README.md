# Christie DHD800 Telnet Command Toolkit

This is a lightweight, open-source toolkit for sending telnet commands to the Christie DHD800 projector using Bash and `expect`. It's designed to enable simple automation of projector controls including power, shutter, input switching, and lens adjustment.

## Project Structure

```
├── README.md           # This file
├── template.sh         # Reusable expect-based command script
├── Templates/          # Demo scripts for quick use
│   ├── PowerOn.sh
│   ├── PowerOff.sh
│   ├── ShutterON.sh
│   └── ShutterOFF.sh
```

## Getting Started

### Requirements

- `bash`
- `expect`
- A network-connected DHD800 projector (direct IP or through a serial-to-IP terminal server)

### Installation

Install `expect` if not already installed:

```bash
brew install expect       # macOS
sudo apt install expect   # Debian/Ubuntu
```

### Usage

1. Open `template.sh`
2. Replace `{{DESTINATION_IP}}` with the IP address of your projector
3. Replace the default command (`C01` in the template) with any of the valid Christie command codes

Alternatively, use one of the prebuilt scripts in the `Templates/` folder.

Give the scripts the appropiate permissions to run:

```bash
chmod a+x ./template.sh # replace with your route (macOS)
```

To power on the projector:

```bash
bash Templates/PowerOn.sh
```

To send a shutter command:

```bash
bash Templates/ShutterON.sh
```

## Functional Command Reference

| Command | Function                | Command | Function                 |
| ------- | ----------------------- | ------- | ------------------------ |
| `C00`   | Power ON                | `C01`   | Power OFF (immediate)    |
| `C05`   | Select Input 1          | `C06`   | Select Input 2           |
| `C07`   | Select Input 3          | `C08`   | Select Input 4           |
| `C0D`   | Video Mute ON (shutter) | `C0E`   | Video Mute OFF (shutter) |
| `C0F`   | Screen Normal Size      | `C10`   | Screen Full Size         |
| `C1C`   | Menu ON                 | `C1D`   | Menu OFF                 |
| `C1E`   | Display Clear           | `C27`   | Image                    |
| `C30`   | Digital Zoom +          | `C31`   | Digital Zoom -           |
| `C3A`   | Pointer Right           | `C3B`   | Pointer Left             |
| `C3C`   | Pointer Up              | `C3D`   | Pointer Down             |
| `C3F`   | Enter                   | `C43`   | Freeze ON                |
| `C44`   | Freeze OFF              | `C46`   | Zoom -                   |
| `C47`   | Zoom +                  | `C4A`   | Focus -                  |
| `C4B`   | Focus +                 | `C5D`   | Lens Shift Up            |
| `C5E`   | Lens Shift Down         | `C5F`   | Lens Shift Left          |
| `C60`   | Lens Shift Right        | `C89`   | Auto PC Adjust           |
| `C8A`   | Presentation Timer      | `C8E`   | Keystone Up              |
| `C8F`   | Keystone Down           | `C90`   | Keystone Right           |
| `C91`   | Keystone Left           |

## Status Read Command Reference

| Command | Description                      |
| ------- | -------------------------------- |
| `CR0`   | Projector Status (Power, Errors) |
| `CR1`   | Current Input Source             |
| `CR3`   | Lamp Time Read                   |
| `CR4`   | Screen Setting Read              |
| `CR6`   | Internal Temperature Read        |
| `CR7`   | Lamp Mode Read                   |

## Use Cases

This toolkit was originally developed to be used in a live theatre environment for automated projector control via [QLab](https://figure53.com/qlab/). Specifically, it was used to control shutter open/close behavior for multiple Christie DHD800 projectors in sync with lighting and sound cues.

Example QLab Integration:

- Create a Shell Script cue
- Point to one of the scripts from the `Templates/` folder (e.g. `ShutterON.sh`)
- Run the cue in sync with video or blackout transitions

This enables precise integration of projector control into complex show automation workflows.

## Notes

- Commands must be in uppercase and terminated with a carriage return (`\r`)
- The projector listens on port `10000` for telnet connections
- There is no actual password in the setup we were using, this may vary, but you must send a return key to pass the initial prompt.
- Commands may be ignored during cooldown or countdown periods; check status with `CR0`
