# Growth

Everyone's growth is unique.

This repository manages **project documentation**, **directory layout**, and **repeatable setup scripts** for local AI-assisted animation workflows (e.g. ComfyUI + open checkpoints). It is licensed under **GPL-3.0** (see [LICENSE](LICENSE)).

## Repository layout

| Path | Purpose |
|------|--------|
| [docs/](docs/) | Human and Cursor-readable setup guides |
| [scripts/](scripts/) | Windows setup automation (`setup-windows.ps1`) |
| [animation/](animation/) | Animation projects, story structure, exported workflows |
| [assets/](assets/) | Reference materials you own or may redistribute (keep licenses in mind) |
| `ComfyUI/` | Local install of [ComfyUI](https://github.com/comfyanonymous/ComfyUI) (not committed; see `.gitignore`) |

## Quick start (new machine)

1. Clone this repo.
2. Open [docs/ENVIRONMENT_SETUP.md](docs/ENVIRONMENT_SETUP.md) in Cursor and follow it **or** run `scripts/setup-windows.ps1` from PowerShell (see doc for details).
3. Large model weights stay **on disk only**; they are **not** in Git. After `git pull`, you still need local Python/venv/models unless you copy them or re-download.

## Git vs. full environment

| In Git | Not in Git (by design) |
|--------|-------------------------|
| Docs, scripts, workflows, **`animation/renders/`** (your pipeline outputs) | `ComfyUI/venv/`, downloaded `.safetensors` (multi-gigabyte checkpoints) |
| Project folder structure | Multi-gigabyte checkpoints |

So: **`git pull` updates this project’s files only.** It does **not** install Python, PyTorch, or model weights. Use the setup doc or `setup-windows.ps1` on each new machine.

## Remote

Upstream GitHub: [jasonwong3709/Growth](https://github.com/jasonwong3709/Growth)

## Cursor on a new machine

Open [docs/CURSOR_HANDOFF.md](docs/CURSOR_HANDOFF.md) and paste its block into a new Cursor chat, or follow [docs/ENVIRONMENT_SETUP.md](docs/ENVIRONMENT_SETUP.md) directly.
